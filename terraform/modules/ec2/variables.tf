variable "pub_key" {
  type = string
}

variable "pr_key" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "public_subnets" {
  type = list(string)
}

