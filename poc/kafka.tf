data "linode_profile" "me" {}

data "linode_sshkey" "my_key" {
  label = "personal computer"
}

resource "linode_instance" "kafka-test" {
  label = "kafka-test"
  type  = "g6-nanode-1"
  image = "linode/ubuntu18.04"
  region = "eu-central"

  backups_enabled = false

  authorized_users = [ data.linode_profile.me.username ]
  authorized_keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6KVjvz1XdVomwzuqWnljsY6FRw2Y09NbbACXxpp9RcpGA8WERhfB4UPWBzy0ECX9vcR+hIMdqilGYhQgShwnSRis9K/NNgVKWZIchp1PfSHkpATRc3cBwOMGBaK8DiEAioUrwPXMnVs6CDGOhDEiE3P6FGXYhEiaAUI+eSZb9Y14crwxu9JeGc/ATyAgKw6pUPKKZKJMncaY8NNuP5kOacrrmpmi6bZe1t9fCBu3AIwrCEogokngHGiYIHZ1z631Vo1nmMwWqqQihTPfLl9bCWMZfpuwfLmGbowYDLAK2tp6W0qXOSLOKSqbhWJMDgzrCiZ28jkaFfw9vM/8p6J3HSiTd7Qoj59txJzhTb962PCSI2KRgUfTis3Mv2T491AKrT2j3/ygK4Jzh9NoTXhle2FgOnOlx3PmKMu58iLERFE3WZmJApBDsyhlcPj9lRp+kA/Q3M0mmHSOvvzYfLi2xQSJeGJkfMgxfpCMG+2SJylWSRw/xPOzcV4VfTcFuZoM= camille chomel@funkit" ]
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