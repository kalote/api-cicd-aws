# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge({
    name = local.name
  }, var.tags)
}

# Create 2 subnets: 1 public (app) / 1 private (db + redis)
resource "aws_subnet" "subnet_public" {
  depends_on              = [aws_vpc.main]
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.20.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = merge({
    Name = "public_subnet"
  }, var.tags)
}

resource "aws_subnet" "subnet_private" {
  depends_on        = [aws_vpc.main]
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.10.30.0/24"
  availability_zone = "eu-central-1b"

  tags = merge({
    Name = "private_subnet"
  }, var.tags)
}

# Create IG to access internet from subnets
resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  tags = merge({
    name = local.name
  }, var.tags)
}

# Create route table with IG
resource "aws_route_table" "route_table" {
  depends_on = [aws_vpc.main, aws_internet_gateway.internet_gateway]
  vpc_id     = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Associate route table with public subnet
resource "aws_route_table_association" "subnet_public_route" {
  depends_on     = [aws_vpc.main, aws_subnet.subnet_public, aws_route_table.route_table]
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_table.id
}

# Create a Elastic IP for the NAT gw
resource "aws_eip" "nat_gw_eip" {
  depends_on = [aws_route_table_association.subnet_public_route]
  domain     = "vpc"
}

# Create a NAT gw
resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_eip.nat_gw_eip]
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.subnet_public.id

  tags = merge({
    Name = "nat_gateway"
  }, var.tags)
}

# Route table for NAT gw
resource "aws_route_table" "route_table_nat_gw" {
  depends_on = [aws_nat_gateway.nat_gw]
  vpc_id     = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge({
    Name = "Route Table for NAT Gateway"
  }, var.tags)

}

# Associate NAT gw route table with private subnet
resource "aws_route_table_association" "nat_gw_public_route" {
  depends_on = [aws_route_table.route_table_nat_gw]

  subnet_id = aws_subnet.subnet_private.id

  route_table_id = aws_route_table.route_table_nat_gw.id
}
