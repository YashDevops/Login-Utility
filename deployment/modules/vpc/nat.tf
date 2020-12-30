#following file contains nat and private subnets
resource "aws_eip" "assignment-nat-eip" {
  vpc = var.True
  tags = {
    Name          = var.Name,
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}
resource "aws_nat_gateway" "assignment-nat-gw" {
  allocation_id = aws_eip.assignment-nat-eip.id
  subnet_id     = aws_subnet.assignment-public-1a.id
  depends_on    = [aws_internet_gateway.assignment-gw]
  tags = {
    Name          = "${var.Name}t-nat-gw",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}


resource "aws_subnet" "assignment-private-1a" {
  vpc_id            = aws_vpc.assignment.id
  cidr_block        = var.private-cidr["cidr-1a"]
  availability_zone = var.az-list[1]
  tags = {
    Name          = "${var.Name}-private-1a",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

resource "aws_subnet" "assignment-private-1b" {
  vpc_id            = aws_vpc.assignment.id
  cidr_block        = var.private-cidr["cidr-1b"]
  availability_zone = var.az-list[1]
  tags = {
    Name          = "${var.Name}-private-1b",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

resource "aws_subnet" "assignment-private-1c" {
  vpc_id            = aws_vpc.assignment.id
  cidr_block        = var.private-cidr["cidr-1c"]
  availability_zone = var.az-list[1]
  tags = {
    Name          = "${var.Name}-private-1c",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

#vpc for nat gateway
resource "aws_route_table" "assignment-private-rt" {
  vpc_id = aws_vpc.assignment.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.assignment-nat-gw.id
  }
  tags = {
    Name          = "${var.Name}private-rt",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}

#route table Association
resource "aws_route_table_association" "assignment-private-1a" {
  subnet_id      = aws_subnet.assignment-private-1a.id
  route_table_id = aws_route_table.assignment-private-rt.id
}

resource "aws_route_table_association" "assignment-private-1b" {
  subnet_id      = aws_subnet.assignment-private-1b.id
  route_table_id = aws_route_table.assignment-private-rt.id
}

resource "aws_route_table_association" "assignment-private-1c" {
  subnet_id      = aws_subnet.assignment-private-1c.id
  route_table_id = aws_route_table.assignment-private-rt.id
}
