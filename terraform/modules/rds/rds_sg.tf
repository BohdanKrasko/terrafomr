resource "aws_security_group" "rds_sg" {
  name   = "my-rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "postgres_inbound_access" {
  from_port         = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  to_port           = 5432
  type              = "ingress"
  cidr_blocks       = [var.cidr_blocks]
}
