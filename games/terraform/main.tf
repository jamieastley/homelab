terraform {
  cloud {

    organization = "jamieastley"

    workspaces {
      name = "homelab-valheim"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.18.0"
    }
  }
}

provider "cloudflare" {}


resource "cloudflare_dns_record" "server" {
  name    = "valheim"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.domain
  comment = "Self-hosted Valheim server"
}

resource "cloudflare_dns_record" "dashboard_wildcards" {
  name    = "*.valheim"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.domain
  comment = "Self-hosted Valheim server internal tools"
}
