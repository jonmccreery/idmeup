resource "google_compute_global_address" "dmz" {
  name = "idmeup-ip"
}

resource "google_compute_target_tcp_proxy" "webservers" {
  name            = "idmeup-proxy"
  backend_service = google_compute_backend_service.webservers.id
}

resource "google_compute_backend_service" "webservers" {
  name                  = "idmeup-backend-service"
  protocol              = "TCP"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.webservers.id]

  backend {
    group           = google_compute_instance_group.webservers.id
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
  }
}

resource "google_compute_instance_group" "webservers" {
  name = "webservers"
  zone = "us-central1-a"

  instances = [
    google_compute_instance.http.id
  ]
}

resource "google_compute_health_check" "webservers" {
  name                = "idmeup-health-check"
  unhealthy_threshold = 1

  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_global_forwarding_rule" "webservers" {
  name                  = "idmeup-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"

  target     = google_compute_target_tcp_proxy.webservers.id
  ip_address = google_compute_global_address.dmz.id
}

resource "google_compute_firewall" "default" {
  name    = "idme-health-check"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # very magical health check subnet.  if this isn't open,
  # health checks fail
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
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
