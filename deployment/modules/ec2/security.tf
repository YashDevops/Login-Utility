#resource for aws sg groups
resource "aws_security_group" "allow-ssh" {
  vpc_id      = var.vpc_id
  name        = "${var.Name}-allow-ssh"
  description = var.description
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    #module.vpc.cidr
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    #module.vpc.cidr
  }
  tags = {
    Name          = var.Name,
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}
