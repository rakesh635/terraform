resource "google_compute_instance" "jenkins-master-01" {
   name = "jenkins-master-01"
   machine_type = "n1-standard-1"
   zone = "asia-south1-a"
   tags = ["jenkins","tf-www-firewall"]
   boot_disk {
      initialize_params {
         image = "ubuntu-1604-lts"
      }
   }

   connection {
      user = "root"
      private_key = "${file("~/.ssh/id_rsa")}"
      agent = false
      host = "${google_compute_instance.jenkins-master-01.network_interface.0.access_config.0.nat_ip}"
   }

   network_interface {
      network = "default"
      access_config {}
   }
   provisioner "file" {
      source = "id_rsa"
      destination = "/root/.ssh/id_rsa1"
   }
   provisioner "remote-exec" {
      inline = [
         "mkdir -p /tmp/terraform/",
         "chmod 777 -R /tmp/terraform/"
      ]
   }
   provisioner "file" {
      source = "script.sh"
      destination = "/tmp/terraform/script.sh"
   }
   provisioner "remote-exec" {
      inline = [
         "chmod 777 -R /tmp/terraform/",
         "/tmp/terraform/script.sh"
      ]
   }
   metadata_startup_script = "${file("script.sh")}"
   metadata = {
      sshKeys = "root:${file("~/.ssh/id_rsa.pub")}"
   }
}
