provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web1" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name                = "treinamento-itau-diego" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet1.id # vincula a subnet direto e gera o IP automático
  private_ip              = "10.50.1.10"
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]
  root_block_device {
    encrypted = true
    volume_size = 8
  }

  tags = {
    Name = "ec2-diego-tf-completo-1"
  }
}

resource "aws_instance" "web2" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name                = "treinamento-itau-diego" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet2.id # vincula a subnet direto e gera o IP automático
  private_ip              = "10.50.16.10"
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]
  root_block_device {
    encrypted = true
    volume_size = 8
  }  

  tags = {
    Name = "ec2-diego-tf-completo-2"
  }
}

resource "aws_instance" "web3" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3.micro"
  key_name                = "treinamento-itau-diego" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet4.id # vincula a subnet direto e gera o IP automático
  private_ip              = "10.50.48.10"
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]
  root_block_device {
    encrypted = true
    volume_size = 8
  }  

  tags = {
    Name = "ec2-diego-tf-completo-3-privada"
  }
}

resource "aws_eip" "example" {
  vpc = true
}

# resource "aws_eip_association" "eip_assoc1" {
#   instance_id   = aws_instance.web1.id
#   allocation_id = aws_eip.example.id
# }

# resource "aws_eip_association" "eip_assoc2" {
#   instance_id   = aws_instance.web2.id
#   allocation_id = aws_eip.example.id
# }

# resource "aws_eip_association" "eip_assoc3" {
#   instance_id   = aws_instance.web3.id
#   allocation_id = aws_eip.example.id
# }
# terraform refresh para mostrar o ssh

output "aws_instance_e_ssh1" {
  value = [
    aws_instance.web1.public_ip,
    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.web1.public_dns}"
  ]
}

output "aws_instance_e_ssh2" {
  value = [
    aws_instance.web2.public_ip,
    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.web2.public_dns}"
  ]
}

output "aws_instance_e_ssh3" {
  value = [
    aws_instance.web3.public_ip,
    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.web3.public_dns}"
  ]
}