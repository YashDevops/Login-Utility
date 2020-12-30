variable "vpc_cidr_block" {
  description = "The vpc cidr block"
  default     = "10.0.0.0/16"
}

variable "tenancy" {
  description = "The tenancy for the vpc"
  default     = "default"
}

variable "True" {
  default = true
}

variable "public-cidr" {
  type        = map(string)
  description = "The public cidr range 1a"
  default = {
    "cidr-1a" = "10.0.1.0/24",
    "cidr-1b" = "10.0.2.0/24",
    "cidr-1c" = "10.0.3.0/24"
  }
}

variable "private-cidr" {
  type        = map(string)
  description = "This is private cidr"
  default = {
    "cidr-1a" = "10.0.4.0/24",
    "cidr-1b" = "10.0.5.0/24",
    "cidr-1c" = "10.0.6.0/24"
  }
}

variable "az-list" {
  type        = list
  description = "The region in which the instance is going to launch"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

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

variable "Type" {
  type    = string
  default = "public"
}
