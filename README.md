# Cloudflare Zero Trust Network Access

Connect to Cloudflare Zero Trust Network using Service Tokens

## Prerequisites
- You should have a Service Token (Client ID and Client Secret) created in Cloudflare Zero Trust
- *Service Auth* should be configured (with the Service Token) as an allowed authentication method to the Access policy protecting your application in Cloudflare Zero Trust

## Limitations of accessing using Service Tokens

#### What Service Tokens CAN Reach
- Applications protected by Cloudflare Access policies
- Services with hostnames configured in Access
- HTTP/HTTPS endpoints behind Access

#### What Service Tokens CANNOT Reach
- **Non-HTTP protocols** (SSH, RDP, databases, etc.) - even if they have hostnames
- Services using arbitrary TCP/UDP ports
- Direct network-layer access (like traditional VPN access to internal IPs)


## ⚙️ Configuration

Store 

<details>
<summary>Inputs</summary>

| Key | Description | Flags | Default |
| --- | --- | --- | --- |
| `cf_client_id` | The Client ID for Cloudflare Serive token. Store the value of the Client ID as an environment variable, and set the environment variable here | required | `$cf_client_id` |
| `cf_client_secret` | The Client Secret for Cloudflare Service token. Store the value of the Client Serce as a sercet variable and set the sercet variable here | required | `$cf_client_secret` |
| `service_endpoint` | The HTTP/HTTPS Service Endpoint URL of the application protected by Cloudflare Zero Trust Access Policies. Store the value of the service endpoint as an environment variable, and set the environment variable here | required | `$service_endpoint` |
| `must_succeed` | Whether the step *must* succeed or not.  | false | `no` |
</details>

<details>
<summary>Outputs</summary>

| Key | Description |
| --- | --- | --- | --- |
| `cf_access_token` | The Access Token for Application access protected by Cloudflare Zero Trust Access Policies. |

</details>



