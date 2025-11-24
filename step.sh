#!/bin/bash
set -e

handle_failure() {
  local message=$1
  if [[ "${must_succeed}" == "no" ]]; then
    echo "WARNING: ${message}"
  else
    echo "${message}"
    exit 1
  fi
}

echo "Starting CF Access Token Fetcher..."
echo "CF Client ID: ${cf_client_id}"
echo "Service Endpoint: ${service_endpoint}"
status_code=$(curl -s -o /dev/null -w "%{http_code}\n" \
  -H "CF-Access-Client-Id: ${cf_client_id}" \
  -H "CF-Access-Client-Secret: ${cf_client_secret}" \
 "${service_endpoint}")
echo "Ping request status code: ${status_code}"
if [[ ${status_code} -ne 200 ]]; then
  handle_failure "Ping request failed with status code ${status_code}"
fi

curl -s -H "CF-Access-Client-Id: ${cf_client_id}" -H "CF-Access-Client-Secret: ${cf_client_secret}" "${service_endpoint}" -c cookie.txt
if [[ $? -ne 0 ]]; then
  handle_failure "Failed to fetch cookies"
fi

cookie=$(awk '/CF_Authorization/ {print $7}' cookie.txt)

status_code=$(curl -s -o /dev/null -w "%{http_code}\n" \
  -H "cookie: CF_Authorization=${cookie}" \
 "${service_endpoint}")
echo "Ping request with cookie status code: ${status_code}"
if [[ "${status_code}" -ne 200 ]]; then
  handle_failure "Ping request with cookie failed with status code ${status_code}"
fi

envman add --key "cf_access_token" --value "${cookie}" --senstive >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  handle_failure "Failed to add cf_access_token to envman"
fi