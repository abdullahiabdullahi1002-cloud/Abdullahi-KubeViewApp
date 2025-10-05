resource "aws_ecs_cluster" "kubeview" {
  name = "${var.project_name}-cluster"
}

#resource "aws_cloudwatch_log_group" "kubeview" {
#  name = "${var.project_name}-log-group"
#}

# Task Definition

resource "aws_ecs_task_definition" "kubeview" {
  family                   = "${var.project_name}-task"
  requires_compatibilities  = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.ecs_task_execution_role

  container_definitions = jsonencode([
    {
      name      = var.project_name
      image     = var.ecr_image_url
      cpu       = var.task_cpu
      memory    = var.task_memory
      essential = true

      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.containerPort
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "kubeview" {
    name                               = "${var.project_name}-service"
    cluster                            = aws_ecs_cluster.kubeview.id
    task_definition                    = aws_ecs_task_definition.kubeview.arn
    propagate_tags                     = "TASK_DEFINITION"
    desired_count                      = 1
    deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
    deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
    launch_type                        = "FARGATE"

    network_configuration {
        subnets          = [var.subnet1_id, var.subnet2_id]
        security_groups  = var.security_group_ecs_ids
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.target_group_arn
        container_name   = "kubeview"
        container_port   = var.containerPort
    }
    depends_on = [ var.alb_https_listener_arn ]
}