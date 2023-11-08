resource "aws_ecs_cluster" "ecs_cluster" {
  name = "my-ecs-cluster"
}

resource "aws_ecs_task_definition" "application" {
  family             = "application"
  network_mode       = "bridge"
  execution_role_arn = aws_iam_role.execution_role.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name      = "application"
      image     = "nginx"
      cpu       = 128
      memory    = 32
      essential = true
      # environment = [
      #   {
      #     name  = "PORT"
      #     value = "80"
      #   }
      # ]
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
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
  lifecycle {
    ignore_changes = [desired_count]
  }

  # network_configuration {
  #   subnets         = [var.subnet1_id, var.subnet2_id]
  #   security_groups = [var.sg_app_id]
  # }

  force_new_deployment = true
  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    redeployment = timestamp()
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 100
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "application"
    container_port   = 80
  }
}
