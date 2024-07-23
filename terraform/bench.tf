resource "google_compute_instance" "bench" {
  name         = "bench"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      #image = "ubuntu-minimal-2004-focal-arm64-v20240714"
      image = "ubuntu-minimal-2404-noble-amd64-v20240717"
    }
  }

  metadata_startup_script = "shutdown -h now"

  network_interface {
    network = "default"
    access_config {}
  }
}
