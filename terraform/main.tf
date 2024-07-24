variable "service_account_keyfile" {}
variable "project" {}

terraform {
  required_providers {
    namecheap = {
      source  = "namecheap/namecheap"
      version = "2.1.2"
    }
  }
}

provider "google" {
  credentials = var.service_account_keyfile
  project     = var.project
}

resource "google_compute_router" "default" {
  name    = "out-router"
  network = "default"
  region  = "us-central1"
}

resource "google_compute_router_nat" "default" {
  name                               = "out-router-nat"
  region                             = "us-central1"
  router                             = google_compute_router.default.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}
