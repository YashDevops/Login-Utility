#terraform file for creating ec2 resources

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = [var.account_id[0]]
}


resource "aws_instance" "assignment" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.inst_type
  count                  = var.no_of_inst
  subnet_id              = var.sub_id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name               = var.ssh_key
  tags = {
    Name          = var.Name,
    BussinessUnit = var.BussinessUnit,
    Project       = var.Project,
    Team          = var.Team
  }
}
