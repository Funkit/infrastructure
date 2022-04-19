terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
}

provider "cloudflare" {
  email   = var.email
  api_key = var.cloudflare_api_key
}

resource "google_compute_instance" "testing-vm" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  tags = ["test"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}

data "cloudflare_zone" "my_zone" {
  name = var.domain
}

resource "cloudflare_record" "testing-vm-record" {
  name     = format("%s.%s","testing-vm",var.domain)
  priority = 75
  proxied  = false
  ttl      = 1
  type     = "A"
  value    = google_compute_instance.testing-vm.network_interface.0.access_config.0.nat_ip 
  zone_id  = data.cloudflare_zone.my_zone.id
}
