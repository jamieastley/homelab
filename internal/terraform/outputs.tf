output "traefik_content" {
  value = cloudflare_dns_record.tailscale_record.content
}
