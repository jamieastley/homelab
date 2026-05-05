variable "zone_id" {
  description = "The Cloudflare Zone ID for the domain to manage."
  type        = string
  sensitive   = true
}

variable "dns_record_content" {
  description = "The content of the DNS record"
}
