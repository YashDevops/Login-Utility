variable "Name" {
  type = string
}

variable "Team" {
  type = string
}

variable "BussinessUnit" {
  type = string
}

variable "Project" {
  type = string
}

variable "account_id" {
  type = list
}

variable "vpc_id" {
  type = string
}

variable "sub_id" {
  type = string
}

variable "inst_type" {
  type    = string
  default = "t2.small"
}

variable "description" {
  type    = string
  default = "This security group is for ssh only"
}

variable "ssh_key" {
  type = string
}

variable "no_of_inst" {
  type    = string
  default = "1"
}
