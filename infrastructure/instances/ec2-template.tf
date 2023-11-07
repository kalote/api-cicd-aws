resource "aws_launch_template" "ecs_template" {
  name_prefix   = "ecs-template"
  image_id      = "ami-062c116e449466e7f" # Amazon Linux ECS 
  instance_type = "t2.micro"

  key_name               = "ec2ecs" # Key pair to ssh onto ec2
  vpc_security_group_ids = [var.sg_app_id, var.sg_mongo_id]
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge({
      Name = "ecs-instance"
    }, var.tags)
  }

  user_data = filebase64("${path.module}/init-ecs.sh")
}
