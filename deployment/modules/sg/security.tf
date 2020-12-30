resource "aws_security_group" "app-sg" {
  vpc_id      = var.vpc_id
  name        = "${var.Name}-app-sg"
  description = var.description
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    #module.vpc.cidr
  }
  tags = {
    Name          = "${var.Name}-sg",
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}
