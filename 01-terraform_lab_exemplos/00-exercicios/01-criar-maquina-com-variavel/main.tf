# variable "instance_type" {
#   type        = string
#   description = "Informe a Instance Type"

#   validation {
#     condition     = length(var.instance_type) > 3 && substr(var.instance_type, 0, 3) == "t2."
#     error_message = "O valor da Instance Type não é válido, tem que começar com \"t2.\"."
#   }
# }
# variable "ami" {
#   type        = string
#   description = "Informe a AMI"

#   validation {
#     condition     = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
#     error_message = "O valor da AMI não é válido, tem que começar com \"ami-\"."
#   }
# }
# variable "subnet" {
#   type        = string
#   description = "Informe a subnet"

#   validation {
#     condition     = length(var.subnet) > 7 && substr(var.subnet, 0, 7) == "subnet-"
#     error_message = "O valor da subnet não é válido, tem que começar com \"subnet-\"."
#   }
# }
# variable "security_group" {
#   type        = string
#   sensitive = true
#   description = "Informe o security group"

#   validation {
#     condition     = length(var.security_group) > 3 && substr(var.security_group, 0, 3) == "sg-"
#     error_message = "O valor do security_group não é válido, tem que começar com \"sg-\"."
#   }
# }

provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0e3bf872589dc8206"
  security_groups = ["sg-099ed40b8b6e66b74"]

#  subnet_id     = var.subnet
#  ami= var.ami
#  instance_type = var.instance_type
#  vpc_security_group_ids = [var.security_group]
  key_name = "chave_key-diego"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-diego-tf-html"
  }
}

resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key-diego"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsc6YnccoGFh56GwYj5HjbSCttOzgj8z9uoCLdu3m+hamVH4dyExFKbCTnG6o+b4am7H+9yk0JEt4HlWwzN3MfaLgRoXHVRH3SpY2LzxfzOBl/xaGgQLRjx0gK7VIFhvfbhAOKtRNST2tb2QwphcEpjU2L98OiFTi0fdnGHNVmBZO35wiuRjbq2VAusqT35Z8GEkxbWHEI3hrT143voU+b8kbJycT/uuJU00q2hdXx4uaUPvkqUEro6HX0EAV08R0oodNoj4+J3KPMaJVspKnLuS1SXuGp3VpOSHK3DNoXciK6FJoCRqdbHylugC9FB+f5ytQSe3m+VKRo3BusmZxEzDg8HbuhNMLTns7qe+FI7nj+cl6tOvo85vf7mRKY3GHJdNL8J31PV/w+tZTE9qu7r1zGBK9bkcWbzQaBQs3vFkHr5dUfuHt/C8TrqFj+vRC2zamnblbBHmK1UN2svv8x5wt4XtIh79LvCVb+eveo1gsLH5I2IvZSMoCUA96N688= ubuntu@ec2-turma2-diego-dev"
}