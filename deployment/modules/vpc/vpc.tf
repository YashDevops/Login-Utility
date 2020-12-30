#following file contains vpc with 3 public and

#vpc
resource "aws_vpc" "assignment" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.True
  enable_dns_hostnames = var.True
  tags = {
    Name          = var.Name,
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

#subnets
resource "aws_subnet" "assignment-public-1a" {
  vpc_id                  = aws_vpc.assignment.id
  cidr_block              = var.public-cidr["cidr-1a"]
  map_public_ip_on_launch = var.True
  availability_zone       = var.az-list[0]
  tags = {
    Name          = "${var.Name}-public-1a",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
    Type          = var.Type
  }
}
resource "aws_subnet" "assignment-public-1b" {
  vpc_id                  = aws_vpc.assignment.id
  cidr_block              = var.public-cidr["cidr-1b"]
  map_public_ip_on_launch = var.True
  availability_zone       = var.az-list[1]
  tags = {
    Name          = "${var.Name}-public-1b",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
    Type          = var.Type
  }
}

resource "aws_subnet" "assignment-public-1c" {
  vpc_id                  = aws_vpc.assignment.id
  cidr_block              = var.public-cidr["cidr-1c"]
  map_public_ip_on_launch = var.True
  availability_zone       = var.az-list[2]
  tags = {
    Name          = "${var.Name}-public-1c",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
    Type          = var.Type
  }
}

#internet Gateway

resource "aws_internet_gateway" "assignment-gw" {
  vpc_id = aws_vpc.assignment.id
  tags = {
    Name          = "${var.Name}-gw",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

#Route Table
resource "aws_route_table" "assignment-public-route-table" {
  vpc_id = aws_vpc.assignment.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.assignment-gw.id
  }
  tags = {
    Name          = "${var.Name}-public-route-table",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

#Route Table Association
resource "aws_route_table_association" "assignment-public-1a" {
  subnet_id      = aws_subnet.assignment-public-1a.id
  route_table_id = aws_route_table.assignment-public-route-table.id
}

resource "aws_route_table_association" "assignment-public-1b" {
  subnet_id      = aws_subnet.assignment-public-1b.id
  route_table_id = aws_route_table.assignment-public-route-table.id
}

resource "aws_route_table_association" "assignment-public-1c" {
  subnet_id      = aws_subnet.assignment-public-1c.id
  route_table_id = aws_route_table.assignment-public-route-table.id
}
