provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  count = 3
  subnet_id = "subnet-0e3bf872589dc8206"
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  key_name = "treinamento-itau-diego"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-diego-tf-${(count.index+1)}"
  }
}

# https://www.terraform.io/docs/language/values/outputs.html
output "instance_public_dns" {
  value = [aws_instance.web.public_dns, aws_instance.web.public_ip, aws_instance.web.private_ip]
  description = "Mostra o DNS e os IPs publicos e privados da maquina criada."
}
# /////


output "instance_public_dns" {
  value = [
    for key, item in var.colaboradores :
      "${key} - ${item.aws_instance.web.public_dns} - ${item.aws_instance.web.public_ip}"
  ]
}