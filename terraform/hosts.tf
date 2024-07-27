---
resource "google_compute_instance" "http" {
  name         = "http"
  machine_type = "${var.default_machine_type}"
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

resource "google_compute_instance" "app" {
  name         = "app"
  machine_type = "${var.default_machine_type}"
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

resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "${var.default_machine_type}"
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
    access_config {}
  }
}

resource "google_compute_instance" "bench" {
  name         = "bench"
  machine_type = "${var.default_machine_type}"
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

resource "google_compute_instance" "db" {
  name         = "db"
  machine_type = "${var.default_machine_type}"
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

resource "google_compute_instance" "monitor" {
  name         = "monitor"
  Machine_type = "${var.default_machine_type}"
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
