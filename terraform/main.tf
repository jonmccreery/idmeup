variable "service_account_keyfile" {}
variable "project" {}

provider "google" {
  credentials = var.service_account_keyfile
  project     = var.project
}
