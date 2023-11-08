# The Application Load Balancer that will front our request
# and redirect to our ec2 instances
# configured with an S3 bucket for access logs
resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_app_id]
  subnets            = [var.subnet1_id, var.subnet2_id]

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.id
    prefix  = "lb-access"
    enabled = true
  }

  tags = merge({
    Name = "ecs-alb"
  }, var.tags)
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path = "/"
  }
}
