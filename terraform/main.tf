variable service_account_keyfile {}
variable project {}

provider "google" {
  credentials = "${var.service_account_keyfile}"
  project     = "${var.project}"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      #image = "ubuntu-minimal-2004-focal-arm64-v20240714"
      image = "ubuntu-minimal-2404-noble-amd64-v20240717"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
