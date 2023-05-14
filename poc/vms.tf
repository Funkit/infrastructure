module "kafka-test" {
  source = "./modules/linode-vm"

  linode_ssh_key_label = "personal"
  instance_label = "kafka-testing"
  instance_type = "g6-standard-2"
  cloudflare_domain = var.cloudflare_domain

  tags = [ "personal-poc" ]
}
