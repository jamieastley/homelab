variable "zone_id" {
  description = "The Cloudflare Zone ID for the domain to manage."
  type        = string
  sensitive   = true
}

variable "record_content" {
  description = "The IP address or FQDN that the DNS records should point to."
}
