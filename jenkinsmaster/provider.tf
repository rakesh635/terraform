provider "google" {
credentials = "${file("projectowner.json")}"
project = "genuine-hold-251617"
region = "asia-south1"
}
