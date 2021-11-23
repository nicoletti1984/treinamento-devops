resource "aws_security_group" "allow_ssh_proj-diego" {
  name        = "allow_ssh_proj-diego"
  description = "Allow SSH inbound traffic"
  vpc_id = "vpc-0aba9c677ce2a010c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      description: "Libera dados da rede interna"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "allow_ssh_proj-diego"
  }
}

output "allow_ssh_proj-diego" {
  value = aws_security_group.allow_ssh_proj-diego.id
}