provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "projeto" {
  ami                         = "ami-0e66f5495b4efdd0f"
  subnet_id                   = "subnet-0e3bf872589dc8206"
  instance_type               = "t2.large"
  key_name                    = "chave_key-diego"
  associate_public_ip_address = true
  root_block_device {
    encrypted   = true
    volume_size = 8
  }
  tags = {
    Name = "projeto"
  }
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
}

resource "aws_security_group" "projeto" {
  name        = "acessos_projeto"
  description = "acessos_projeto inbound traffic"
  vpc_id      = "vpc-0aba9c677ce2a010c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "SSH from VPC"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "projeto-lab"
  }
}

# terraform refresh para mostrar o ssh
output "projeto" {
  value = [
    "projeto",
    "id: ${aws_instance.projeto.id}",
    "private: ${aws_instance.projeto.private_ip}",
    "public: ${aws_instance.projeto.public_ip}",
    "public_dns: ${aws_instance.projeto.public_dns}",
    "ssh -i '~/id_rsa.pem' ubuntu@${aws_instance.jprojeto.public_dns}"
  ]
}
