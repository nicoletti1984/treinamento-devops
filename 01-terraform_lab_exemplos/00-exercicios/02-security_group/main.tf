provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  subnet_id = "subnet-0e3bf872589dc8206"
  vpc_security_group_ids = ["${aws_security_group.diego_ssh.id}"]

  key_name = "treinamento-itau-diego"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-diego-tf2"
  }
}

# https://www.terraform.io/docs/language/values/outputs.html
output "instance_public_dns" {
  value = [aws_instance.web.public_dns, aws_instance.web.public_ip, aws_instance.web.private_ip]
  description = "Mostra o DNS e os IPs publicos e privados da maquina criada."
}
# /////