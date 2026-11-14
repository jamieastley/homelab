variable "zone_id" {
  description = "The Cloudflare Zone ID for the domain to manage."
  type        = string
  sensitive   = true
}

variable "pihole_lan_ip" {
  description = "The LAN IP address of the Pi-hole device."
  type        = string
  sensitive   = true
}
