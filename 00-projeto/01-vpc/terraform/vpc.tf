resource "aws_subnet" "proj-diego-subnet-1a" {
  vpc_id            = "vpc-0aba9c677ce2a010c"
  cidr_block        = "10.30.0.0/20"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "proj-diego-subnet-1a"
  }
}

resource "aws_subnet" "proj-diego-subnet-1b" {
  vpc_id      = "vpc-0aba9c677ce2a010c"
  cidr_block        = "10.30.16.0/20"
  availability_zone = "sa-east-1b"

  tags = {
    Name = "proj-diego-subnet-1b"
  }
}

resource "aws_subnet" "proj-diego-subnet-1c" {
  vpc_id      = "vpc-0aba9c677ce2a010c"
  cidr_block        = "10.30.32.0/20"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "proj-diego-subnet-1c"
  }
}

resource "aws_subnet" "proj-diego-subnet-2a" {
  vpc_id      = "vpc-0aba9c677ce2a010c"
  cidr_block        = "10.30.48.0/20"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "proj-diego-subnet-2a"
  }
}


# resource "aws_route_table" "proj-diego-rt_terraform" {
#   vpc_id = "vpc-0aba9c677ce2a010c"

#   route = [
#       #{
#         # carrier_gateway_id         = ""
#         # cidr_block                 = "0.0.0.0/0"
#         # destination_prefix_list_id = ""
#         # egress_only_gateway_id     = ""
#         # #gateway_id                 = aws_internet_gateway.gw.id
#         # gateway_id                 = ""
#         # instance_id                = ""
#         # ipv6_cidr_block            = ""
#         # local_gateway_id           = ""
#         # nat_gateway_id             = ""
#         # network_interface_id       = ""
#         # transit_gateway_id         = ""
#         # vpc_endpoint_id            = ""
#         # vpc_peering_connection_id  = ""
#       #}
#   ]

#   tags = {
#     Name = "route_table_terraform-diego"
#   }
# }

# resource "aws_route_table" "rt_terraform_privada" {
#   vpc_id = aws_vpc.my_vpc.id

#   route = [
#       # {
#       #   carrier_gateway_id         = ""
#       #   cidr_block                 = "0.0.0.0/0"
#       #   destination_prefix_list_id = ""
#       #   egress_only_gateway_id     = ""
#       #   gateway_id                 = ""
#       #   instance_id                = ""
#       #   ipv6_cidr_block            = ""
#       #   local_gateway_id           = ""
#       #   nat_gateway_id             = ""
#       #   network_interface_id       = ""
#       #   transit_gateway_id         = ""
#       #   vpc_endpoint_id            = ""
#       #   vpc_peering_connection_id  = ""
#       # }
#   ]

#   tags = {
#     Name = "route_table_terraform-diego-privada"
#   }
# }

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.proj-diego-subnet-1a.id
#   route_table_id = aws_route_table.rt_terraform.id
# }

# resource "aws_route_table_association" "b" {
#   subnet_id      = aws_subnet.proj-diego-subnet-1b.id
#   route_table_id = aws_route_table.rt_terraform.id
# }

# resource "aws_route_table_association" "c" {
#   subnet_id      = aws_subnet.proj-diego-subnet-1c.id
#   route_table_id = aws_route_table.rt_terraform_privada.id
# }