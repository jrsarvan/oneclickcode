resource "aws_key_pair" "newkey" {
  key_name = "newkey"
  public_key = "${file("${var.PUB_KEY_PATH}")}"
}
resource "aws_instance" "my_instance" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "${aws_key_pair.newkey.key_name}"
    tags = {
      name = "New_instance"
    }
    provisioner "remote-exec" {
      inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = "${var.USER}"
      private_key = "${file("${var.PRIV_KEY_PATH}")}"
      host        = aws_instance.my_instance.public_ip
    }
  }
    provisioner "local-exec" {
      command = "ansible-playbook  -i ${aws_instance.my_instance.public_ip}, --private-key ${var.PRIV_KEY_PATH} ubuntu.yaml"
  }
}

output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

