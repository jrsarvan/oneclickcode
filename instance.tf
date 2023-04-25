resource "aws_key_pair" "my-key" {
  key_name = "my-key"
  public_key = "${file("${var.PUB_KEY_PATH}")}"
}
resource "aws_instance" "my_instance" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "${aws_key_pair.my-key.key_name}"
    tags = {
      name = "New_instance"
    }

    provisioner "file" {
      source = "new.sh"
      destination = "/tmp/new.sh"
    }
    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/new.sh",
        "sudo /tmp/new.sh"
      ]
    }
    connection {
      type = "ssh"
      host = self.public_ip
      user = "${var.USER}"
      private_key = "${file("${var.PRIV_KEY_PATH}")}"
      
    }
}

output "instance_public_ip" {
  value = "${aws_instance.my_instance.public_ip}"
}

