output "vpc_id" {
  value = aws_vpc.assignment.id
}

output "public_1a" {
  value = aws_subnet.assignment-public-1a.id
}

output "public_1b" {
  value = aws_subnet.assignment-public-1b.id
}

output "public_1c" {
  value = aws_subnet.assignment-public-1c.id
}

output "private_1a" {
  value = aws_subnet.assignment-private-1a.id
}

output "private_1b" {
  value = aws_subnet.assignment-private-1b.id
}

output "private_1c" {
  value = aws_subnet.assignment-private-1c.id
}

output "private_1a_subnet" {
  value = aws_subnet.assignment-private-1a.availability_zone
}


output "private_1b_subnet" {
  value = aws_subnet.assignment-private-1b.availability_zone
}


output "private_1c_subnet" {
  value = aws_subnet.assignment-private-1c.availability_zone
}


output "public_1a_subnet" {
  value = aws_subnet.assignment-public-1a.availability_zone
}

output "public_1b_subnet" {
  value = aws_subnet.assignment-public-1b.availability_zone
}

output "public_1c_subnet" {
  value = aws_subnet.assignment-public-1c.availability_zone
}
