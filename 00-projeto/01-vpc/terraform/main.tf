provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "ec2-proj-diego" {
  ami           = "ami-0e66f5495b4efdd0f"
  subnet_id     = aws_subnet.proj-diego-subnet-1a.id  
  instance_type = "t2.medium"
  key_name = "chave_key-diego"
  associate_public_ip_address = true
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_proj-diego.id}",  
  ]    
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  count         = 3
  tags = {
    Name = "ec2-proj-diego-${count.index}"
  }
}


output "maquinas" {
  value = [
    for key, item in aws_instance.ec2-proj-diego :
      "ec2-proj-diego-${key+1} - ${item.private_ip} - ssh -i '~/id_rsa.pem' ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "security-group-diego-proj-sg" {
  value = "${aws_security_group.allow_ssh_proj-diego.id}"
}

# terraform refresh para mostrar o ssh