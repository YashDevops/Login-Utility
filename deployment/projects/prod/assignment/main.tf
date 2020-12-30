#the main.tf file
data "aws_subnet_ids" "subnet" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Type = "public"
  }
}

resource "null_resource" "cluster" {
  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host        = module.node1.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../../../keys/id_rsa")
  }


  provisioner "file" {
    source      = "../../../keys/id_rsa"
    destination = "~/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sleep 10s",
      "sudo apt update; sudo apt install ansible -y",
      "sleep 10s",
      "export ANSIBLE_HOST_KEY_CHECKING=False;",
      "git clone https://github.com/YashDevops/Login-Utility.git",
      "sleep 10s",
      "chmod 400 /home/ubuntu/.ssh/id_rsa",
      "ansible-playbook Assignment/Ansible/Login-Utility-Deployment/playbooks/release.yml -i localhost, -u ubuntu -e 'ansible_python_interpreter=/usr/bin/python3'",
      "sleep 60s"
    ]
    on_failure = continue
  }
}

module "vpc" {
  source        = "../../../modules/vpc"
  Name          = var.Name
  BussinessUnit = var.BussinessUnit
  Team          = var.Team
  Project       = var.Project
}

module "key" {
  source             = "../../../modules/keys"
  key_name           = "mediawiki-keys"
  PATH_TO_PUBLIC_KEY = "../../../keys/id_rsa.pub"
}

module "node1" {
  source        = "../../../modules/ec2"
  account_id    = [var.account_id]
  vpc_id        = module.vpc.vpc_id
  sub_id        = module.vpc.public_1a
  ssh_key       = module.key.key_name
  Name          = "${var.Name}-bastion"
  BussinessUnit = var.BussinessUnit
  Team          = var.Team
  Project       = var.Project
}
