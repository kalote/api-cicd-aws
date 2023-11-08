resource "aws_instance" "mongo" {
  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = "t2.micro"
  subnet_id            = var.subnet_private_id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  key_name = "ec2ecs"

  vpc_security_group_ids = [var.sg_mongo_id]

  tags = {
    Name = "Mongo"
  }
  user_data = templatefile("${path.module}/init-mongo.sh", {})
}
