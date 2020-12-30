variable "key_name" {
  type    = string
  default = "Terraform-key"
}

variable "PATH_TO_PUBLIC_KEY" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
