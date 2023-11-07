resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-ecs-cluster"
}

resource "aws_ecs_task_definition" "application" {
  family       = "application"
  network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "application"
      image     = "${var.repo_url}:${var.app_version}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "application" {
  name            = "application"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.application.arn
  desired_count   = "1"

  placement_constraints {
    type = "distinctInstance"
  }

  network_configuration {
    subnets         = [var.subnet1_id, var.subnet2_id]
    security_groups = [var.sg_app_id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "application"
    container_port   = 80
  }
}
