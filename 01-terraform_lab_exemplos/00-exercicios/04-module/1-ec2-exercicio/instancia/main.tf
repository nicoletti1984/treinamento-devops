resource "aws_instance" "web" {
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0e3bf872589dc8206"
  security_groups = ["sg-099ed40b8b6e66b74"]


  key_name = "treinamento-itau-diego"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}",
    Itau = true
  }
}