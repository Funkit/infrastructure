
data "cloudflare_zone" "my_zone" {
  name = var.cloudflare_domain
}

resource "cloudflare_record" "email_MX_route_3" {
  name     = var.cloudflare_domain
  priority = 75
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route3.mx.cloudflare.net"
  zone_id  = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "email_MX_route_2" {
  name     = var.cloudflare_domain
  priority = 12
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route2.mx.cloudflare.net"
  zone_id  = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "email_MX_route_1" {
  name     = var.cloudflare_domain
  priority = 30
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "route1.mx.cloudflare.net"
  zone_id  = data.cloudflare_zone.my_zone.id
}

resource "cloudflare_record" "email_TXT" {
  name    = var.cloudflare_domain
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  zone_id = data.cloudflare_zone.my_zone.id
}
