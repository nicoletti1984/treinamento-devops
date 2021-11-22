provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0e3bf872589dc8206"
  security_groups = ["sg-099ed40b8b6e66b74"]
  key_name = "chave_key-diego"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-diego-tf-java"
  }
}

resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key-diego"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsc6YnccoGFh56GwYj5HjbSCttOzgj8z9uoCLdu3m+hamVH4dyExFKbCTnG6o+b4am7H+9yk0JEt4HlWwzN3MfaLgRoXHVRH3SpY2LzxfzOBl/xaGgQLRjx0gK7VIFhvfbhAOKtRNST2tb2QwphcEpjU2L98OiFTi0fdnGHNVmBZO35wiuRjbq2VAusqT35Z8GEkxbWHEI3hrT143voU+b8kbJycT/uuJU00q2hdXx4uaUPvkqUEro6HX0EAV08R0oodNoj4+J3KPMaJVspKnLuS1SXuGp3VpOSHK3DNoXciK6FJoCRqdbHylugC9FB+f5ytQSe3m+VKRo3BusmZxEzDg8HbuhNMLTns7qe+FI7nj+cl6tOvo85vf7mRKY3GHJdNL8J31PV/w+tZTE9qu7r1zGBK9bkcWbzQaBQs3vFkHr5dUfuHt/C8TrqFj+vRC2zamnblbBHmK1UN2svv8x5wt4XtIh79LvCVb+eveo1gsLH5I2IvZSMoCUA96N688= ubuntu@ec2-turma2-diego-dev"
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    aws_instance.web.public_ip,aws_instance.web.public_dns
  ]
}

# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ../../id_rsa_itau_treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
# conferir 
