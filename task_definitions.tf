resource "aws_ecs_task_definition" "app_task" {
  count = var.enable_ecs ? 1 : 0
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "ecs-java-crud"
      image     = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/ecs-java-crud:latest"
      cpu       = 128
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/trigger-redeploy"
          awslogs-region        = "${var.region}"
          awslogs-stream-prefix = "java"
        }
      }
    },
    {
      name      = "titanic-fastapi-ecs"
      image     = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/titanic-fastapi-ecs:latest"
      cpu       = 64
      memory    = 128
      essential = false
      portMappings = [
        {
          containerPort = 8001
          hostPort      = 8001
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/trigger-redeploy"
          awslogs-region        = "${var.region}"
          awslogs-stream-prefix = "titanic"
        }
      }
    },
    {
      name      = "crud-ecs-python"
      image     = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/crud-ecs-python:latest"
      cpu       = 128
      memory    = 256
      essential = false
      portMappings = [
        {
          containerPort = 8002
          hostPort      = 8002
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/trigger-redeploy"
          awslogs-region        = "${var.region}"
          awslogs-stream-prefix = "python"
        }
      }
    }
  ])
}
