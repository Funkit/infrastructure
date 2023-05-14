terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }

    linode = {
      source  = "linode/linode"
      version = "~> 1.29.4"
    }
  }
}

data "linode_sshkey" "my_key" {
  label = var.linode_ssh_key_label
}

resource "linode_instance" "my_instance" {
  label = var.instance_label
  type  = var.instance_type
  image = "linode/ubuntu18.04"
  region = "eu-central"
  tags = var.tags

  backups_enabled = false

  authorized_keys = [ data.linode_sshkey.my_key.ssh_key ]
}

data "cloudflare_zone" "my_zone" {
  name = var.cloudflare_domain
}

resource "cloudflare_record" "my_instance_record" {
  name     = format("%s.%s", var.instance_label, var.cloudflare_domain)
  priority = 75
  proxied  = false
  ttl      = 1
  type     = "A"
  value    = linode_instance.my_instance.ip_address
  zone_id  = data.cloudflare_zone.my_zone.id
}
