resource "google_dns_managed_zone" "idmeup" {
  dns_name = "idmeup.site."
  name     = "idmeup"
}

resource "google_dns_record_set" "www" {
  managed_zone = google_dns_managed_zone.idmeup.name
  name = "www.idmeup.site."
  type = "A"
  rrdatas =  [google_compute_global_address.dmz.address]
}
