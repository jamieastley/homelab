output "server_record_id" {
  value = cloudflare_dns_record.server.id
}

output "dashboard_wildcards_record_id" {
  value = cloudflare_dns_record.dashboard_wildcards.id
}
