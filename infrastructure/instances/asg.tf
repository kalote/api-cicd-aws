# Auto scaling group for our ec2 instances in 2 different AZ:
# - At least 2
# - max 2
# - min 1
resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1

  launch_template {
    id      = aws_launch_template.ecs_template.id
    version = aws_launch_template.ecs_template.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    triggers = ["tag"]
  }

  tag {
    key                 = "launch version"
    value               = aws_launch_template.ecs_template.latest_version
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
