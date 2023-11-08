resource "aws_instance" "application" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_public_id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  key_name = "ec2ecs"

  vpc_security_group_ids = [var.sg_app_id]

  tags = {
    Name = "Application"
  }
  user_data = templatefile("${path.module}/templates/init-application.sh", {
    repo_url          = "${var.ecr_repo_url}"
    app_version       = "${var.app_version}"
    registry_id       = "${var.registry_id}"
    registry_region   = "${var.registry_region}"
    redis_instance_ip = "${aws_instance.redis.private_ip}"
    mongo_instance_ip = "${aws_instance.mongo.private_ip}"
  })

  user_data_replace_on_change = true
}
