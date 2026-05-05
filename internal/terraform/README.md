# Homelab - Terraform module

A module to create and manage the DNS record the internal services of the homelab.

## Required environment variables

Add the following values into `.env`:

| Variable                    | Description                                           |
|-----------------------------|-------------------------------------------------------|
| `TF_VAR_zone_id`            | The zone ID for the Cloudflare account                |
| `TF_VAR_dns_record_content` | The content of the DNS record will be created against |
| `CLOUDFLARE_API_TOKEN`      | The API token for the Cloudflare account              |