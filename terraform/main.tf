provider "google" {
  credentials = "${var.service_account_keyfile}"
  project     = "${var.project}"
}
