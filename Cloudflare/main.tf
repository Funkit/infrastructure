# Configure the Cloudflare provider using the required_providers stanza required with Terraform 0.13 and beyond
# You may optionally use version directive to prevent breaking changes occurring unannounced.
terraform {
  cloud {
    organization = "Funkit"

    workspaces {
      name = "sandbox"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  email   = var.email
  api_key = var.api_key
}

data "cloudflare_zone" "my_zone" {
  name = var.domain
}

resource "cloudflare_record" "email_MX_route_3" {
  name     = var.domain
  priority = 75
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route3.mx.cloudflare.net"
  zone_id  = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "email_MX_route_2" {
  name     = var.domain
  priority = 12
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route2.mx.cloudflare.net"
  zone_id  = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "email_MX_route_1" {
  name     = var.domain
  priority = 30
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route1.mx.cloudflare.net"
  zone_id  = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "google_verification_record" {
  name    = var.domain
  proxied = false
  ttl     = 3600
  type    = "TXT"
  value   = var.google_verification_record
  zone_id = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "email_TXT" {
  name    = var.domain
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  zone_id = data.cloudflare_zone.my_zone.id
}
