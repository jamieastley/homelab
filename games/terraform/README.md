# Valheim - Terraform module

A module to create and manage the DNS records for the Valheim server stack

## Required environment variables

Add the following values into `.env`:

| Variable               | Description                                              |
|------------------------|----------------------------------------------------------|
| `TF_VAR_zone_id`       | The zone ID for the Cloudflare account                   |
| `TF_VAR_domain`        | The domain name that the records will be created against |
| `CLOUDFLARE_API_TOKEN` | The API token for the Cloudflare account                 |