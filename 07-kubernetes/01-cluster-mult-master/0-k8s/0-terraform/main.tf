provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "k8s_proxy" {
  ami           = "ami-0e66f5495b4efdd0f"
  subnet_id     = "subnet-0e3bf872589dc8206"
  instance_type = "t2.medium"
  key_name = "chave_key-diego-cluster-multi"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "k8s-haproxy"
  }
  vpc_security_group_ids = [aws_security_group.acessos_haproxy.id]
}

resource "aws_instance" "k8s_masters" {
  ami           = "ami-0e66f5495b4efdd0f"
  subnet_id     = "subnet-0e3bf872589dc8206"  
  instance_type = "t2.large"
  key_name = "chave_key-diego-cluster-multi"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  count         = 3
  tags = {
    Name = "k8s-master-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_masters.id]
  depends_on = [
    aws_instance.k8s_workers,
  ]
}

resource "aws_instance" "k8s_workers" {
  ami           = "ami-0e66f5495b4efdd0f"
  subnet_id     = "subnet-0e3bf872589dc8206"  
  instance_type = "t2.medium"
  key_name = "chave_key-diego-cluster-multi"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  count         = 3
  tags = {
    Name = "k8s_workers-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers.id]
}


resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key-diego-cluster-multi"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCsc6YnccoGFh56GwYj5HjbSCttOzgj8z9uoCLdu3m+hamVH4dyExFKbCTnG6o+b4am7H+9yk0JEt4HlWwzN3MfaLgRoXHVRH3SpY2LzxfzOBl/xaGgQLRjx0gK7VIFhvfbhAOKtRNST2tb2QwphcEpjU2L98OiFTi0fdnGHNVmBZO35wiuRjbq2VAusqT35Z8GEkxbWHEI3hrT143voU+b8kbJycT/uuJU00q2hdXx4uaUPvkqUEro6HX0EAV08R0oodNoj4+J3KPMaJVspKnLuS1SXuGp3VpOSHK3DNoXciK6FJoCRqdbHylugC9FB+f5ytQSe3m+VKRo3BusmZxEzDg8HbuhNMLTns7qe+FI7nj+cl6tOvo85vf7mRKY3GHJdNL8J31PV/w+tZTE9qu7r1zGBK9bkcWbzQaBQs3vFkHr5dUfuHt/C8TrqFj+vRC2zamnblbBHmK1UN2svv8x5wt4XtIh79LvCVb+eveo1gsLH5I2IvZSMoCUA96N688= ubuntu@ec2-turma2-diego-dev"
}

resource "aws_security_group" "acessos_masters" {
  name        = "k8s-acessos_masters"
  description = "acessos inbound traffic"
  vpc_id = "vpc-0aba9c677ce2a010c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_masters"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_haproxy"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "sg-02d77dc2c2c9a68c3",
        //"${aws_security_group.acessos_haproxy.id}",
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 65535
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "acessos_haproxy" {
  name        = "k8s-haproxy"
  description = "acessos inbound traffic"
  vpc_id = "vpc-0aba9c677ce2a010c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "sg-028655a64c6266618",
        #aws_security_group.acessos_masters.id,
      ]
      self             = false
      to_port          = 0
    }, 
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        #aws_security_group.acessos_workers.id,
        "sg-0495253ba39fd1062",
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 65535
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_haproxy_ssh"
  }
}

resource "aws_security_group" "acessos_workers" {
  name        = "k8s-workers"
  description = "acessos inbound traffic"
  vpc_id = "vpc-0aba9c677ce2a010c"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        aws_security_group.acessos_masters.id,
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 65535
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh"
  }
}

output "k8s-masters" {
  value = [
    for key, item in aws_instance.k8s_masters :
      "k8s-master ${key+1} - ${item.private_ip} - ssh -i '~/id_rsa.pem' ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_workers" {
  value = [
    for key, item in aws_instance.k8s_workers :
      "k8s-workers ${key+1} - ${item.private_ip} - ssh -i '~/id_rsa.pem' ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_proxy" {
  value = [
    "k8s_proxy - ${aws_instance.k8s_proxy.private_ip} - ssh -i '~/id_rsa.pem' ubuntu@${aws_instance.k8s_proxy.public_dns} -o ServerAliveInterval=60"
  ]
}

output "security-group-master" {
  value = aws_security_group.acessos_masters.id
}

output "security-group-workers" {
  value = aws_security_group.acessos_workers.id
}

output "security-group-workers-e-haproxy" {
  value = aws_security_group.acessos_haproxy.id
}




# terraform refresh para mostrar o ssh