resource "aws_security_group" "security_group_app" {
  depends_on = [aws_vpc.main, aws_subnet.subnet_public]
  name       = "security-group-application"
  vpc_id     = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  # SSH access only from my home computer
  # Will be removed
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["83.51.43.43/32"]
    description = "SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    name = local.name
  }, var.tags)
}

resource "aws_security_group" "security_group_mongo" {
  depends_on = [aws_vpc.main, aws_subnet.subnet_private]
  name       = "security-group-private"
  vpc_id     = aws_vpc.main.id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.subnet_public.cidr_block}"]
    description = "MONGO"
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.subnet_public.cidr_block}"]
    description = "REDIS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    name = local.name
  }, var.tags)
}
