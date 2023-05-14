output "fqdn" {
  description = "Linode instance's FQDN"
  value       = cloudflare_record.my_instance_record.hostname
}