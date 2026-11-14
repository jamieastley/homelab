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
      version = "~> 5.28.0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.29.2"
    }
  }
}

provider "cloudflare" {}

provider "tailscale" {
  # Provided by the following env vars:
  #
  # TAILSCALE_OAUTH_CLIENT_ID
  # TAILSCALE_OAUTH_CLIENT_SECRET
  # TAILSCALE_TAILNET
}

data "tailscale_device" "homelab" {
  hostname = "homelab"
  wait_for = "10s"
}

locals {
  ipv4_address = [
    for addr in data.tailscale_device.homelab.addresses : addr
    if can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+", addr))
  ][0]
}

resource "tailscale_device_subnet_routes" "pihole" {
  device_id = data.tailscale_device.homelab.id
  routes    = ["${var.pihole_lan_ip}/32"]
}

resource "tailscale_dns_configuration" "tailnet" {
  nameservers {
    address = var.pihole_lan_ip
  }

  override_local_dns = true
  magic_dns          = true

  depends_on = [tailscale_device_subnet_routes.pihole]
}

resource "cloudflare_dns_record" "tailscale_record" {
  name    = "*.ts"
  ttl     = 60
  type    = "A"
  zone_id = var.zone_id
  proxied = false
  content = local.ipv4_address
  comment = "Homelab Tailscale DNS record"
}
