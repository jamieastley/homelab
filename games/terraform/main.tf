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

resource "cloudflare_dns_record" "traefik" {
  name    = "traefik"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.domain
  comment = "Traefik dashboard and API"
}

resource "cloudflare_dns_record" "hytale" {
  name    = "hytale"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.domain
  comment = "Self-hosted Hytale server"
}

resource "cloudflare_dns_record" "valheim" {
  name    = "valheim"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.domain
  comment = "Self-hosted Valheim server"
}

resource "cloudflare_dns_record" "valheim_tools" {
  name    = "*.valheim"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.domain
  comment = "Self-hosted Valheim server internal tools"
}
