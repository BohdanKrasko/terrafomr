variable "pub_key" {
  type    = string
  default = "~/.ssh/london-ec2.pub"
}

variable "pr_key" {
  type    = string
  default = "~/.ssh/london-ec2"
}

variable "vpc_name" {
  type    = string
  default = "vpc"
}
variable "instance_count" {
  type    = number
  default = 1
}
variable "igw_name" {
  type    = string
  default = "igw"
}
variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

