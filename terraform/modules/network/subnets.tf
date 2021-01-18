data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = format("public-%d", count.index)
  }

}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = format("private-%d", count.index)
    Tier = "Private"
  }
}



resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table-public"
  }
}

resource "aws_route_table_association" "subnet-association-public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.route-table.id
}

data "aws_subnet_ids" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Tier = "Private"
  }
  depends_on = [
    aws_subnet.private
  ]
}

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["public-0", "public-1"]
  }
    depends_on = [
    aws_subnet.public
  ]
}
