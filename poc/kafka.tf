data "linode_sshkey" "my_key" {
  label = "personal"
}

resource "linode_instance" "kafka-test" {
  label = "kafka-test"
  type  = "g6-standard-2"
  image = "linode/ubuntu18.04"
  region = "eu-central"
  tags = [ "personal" ]

  backups_enabled = false

  authorized_keys = [ data.linode_sshkey.my_key.ssh_key ]
}

data "cloudflare_zone" "my_zone" {
  name = var.cloudflare_domain
}

resource "cloudflare_record" "testing-vm-record" {
  name     = format("%s.%s","kafka-test",var.cloudflare_domain)
  priority = 75
  proxied  = false
  ttl      = 1
  type     = "A"
  value    = linode_instance.kafka-test.ip_address
  zone_id  = data.cloudflare_zone.my_zone.id
}