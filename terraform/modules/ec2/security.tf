variable "service_ports" {
  default = [
    {
      from_port = "22",
      to_port   = "22"
    },
    {
      from_port = "80",
      to_port   = "80"
    },
    {
      from_port = "443",
      to_port   = "443"
    }

  ]
}

variable "accessip" {
  default = "0.0.0.0/0"
}

resource "aws_security_group" "sg-http-https-ssh" {
  name   = "sgg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = [for i in var.service_ports : {
      from_port = i.from_port
      to_port   = i.to_port
    }]
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = [var.accessip]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
