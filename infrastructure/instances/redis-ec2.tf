resource "aws_instance" "redis" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_private_id
  associate_public_ip_address = true # debug only
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  key_name = "ec2ecs"

  vpc_security_group_ids = [var.sg_mongo_id]

  tags = {
    Name = "Redis"
  }
  user_data = filebase64("${path.module}/templates/init-redis.sh")
}
