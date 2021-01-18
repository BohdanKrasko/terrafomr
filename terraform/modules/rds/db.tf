#data "aws_secretsmanager_secret_version" "creds" {
#  secret_id = "db_cred"
#}

#locals {
#  db_creds = jsondecode(
#    data.aws_secretsmanager_secret_version.creds.secret_string
#  )
#}
resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "12.4"
  instance_class         = "db.t2.micro"
  port                   = "5432"
  name                   = "dbpostgres"
  #username               = local.db_creds.username
  #password               = local.db_creds.password
  username = "root"
  password = "qwerty123"
  parameter_group_name   = "default.postgres12"
  db_subnet_group_name   = aws_db_subnet_group.rds-private-subnet.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
}
