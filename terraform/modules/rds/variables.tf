variable "subnet_ids" {
  description = "Subnets id for db group"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cidr_blocks" {
  description = "Cidr block 0.0.0.0/0"
  type        = string
  default     = "0.0.0.0/0"
}
