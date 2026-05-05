terraform {
  cloud {

    organization = "jamieastley"

    workspaces {
      name = "homelab-internal"
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

resource "cloudflare_dns_record" "tailscale_record" {
  name    = "*.ts"
  ttl     = 60
  type    = "CNAME"
  zone_id = var.zone_id
  proxied = false
  content = var.dns_record_content
  comment = "Homelab Tailscale DNS record"
}
