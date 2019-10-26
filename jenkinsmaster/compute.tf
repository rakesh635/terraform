resource "google_compute_firewall" "www" {
  name = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8080", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
