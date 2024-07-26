resource "google_compute_instance" "bench" {
  name         = "bench"
  machine_type = "e2-micro"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  metadata = {
    ssh-keys = "ansible:${file("../../secret/ansible.pub")}"
  }

  network_interface {
    network = "default"
  }
}
