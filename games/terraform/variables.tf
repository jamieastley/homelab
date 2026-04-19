variable "zone_id" {
  description = "The Cloudflare Zone ID for the domain to manage."
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "The domain that the DNS records will be created against."
}
