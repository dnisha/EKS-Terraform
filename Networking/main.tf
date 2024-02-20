locals {
  public_subnet_cidrs = merge([
    for az, cidr_blocks in var.public_subnet_cidrs : {
      for cidr_block in cidr_blocks :
      cidr_block => az
    }
  ]...)
}

locals {
  private_subnet_cidrs = merge([
    for az, cidr_blocks in var.private_subnet_cidrs : {
      for cidr_block in cidr_blocks :
      cidr_block => az
    }
  ]...)
}

resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "pub_subnet" {
  for_each          = local.public_subnet_cidrs
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value
  cidr_block        = each.key
}

resource "aws_subnet" "private_subnet" {
  for_each          = local.private_subnet_cidrs
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value
  cidr_block        = each.key
}

### Pubic Routings #####

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
}


resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public-subnet-association" {
  for_each       = aws_subnet.pub_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

#### Private Routings #####

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "private-route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private-subnet-association" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "eip" {
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = tolist(values(aws_subnet.pub_subnet).*.id)[0]
}
