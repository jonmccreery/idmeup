provider "google" {
  credentials = var.service_account_keyfile
  project     = var.project
}

provider "local" {}

resource "google_project_service" "dns" {
  project = var.project
  service = "dns.googleapis.com"
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  project = var.project
}
