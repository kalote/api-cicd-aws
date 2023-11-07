# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge({
    name = local.name
  }, var.tags)
}

# Create 2 subnets for resilience for our app
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.20.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.30.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"
}

# Create IG to access internet from subnets
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = merge({
    name = local.name
  }, var.tags)
}

# Create route table with IG
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Associate route table with subnets
resource "aws_route_table_association" "subnet1_route" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}
