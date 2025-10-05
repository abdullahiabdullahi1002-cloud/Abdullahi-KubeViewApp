variable "project_name" {
  type        = string
}

variable "subnet1_id" {
  description = "The subnet ID 1 where the ALB will be deployed"
  type        = string
}

variable "subnet2_id" {
  description = "The subnet ID 2 where the ALB will be deployed"
  type        = string
}

variable "security_group_ecs_ids" {
  description = "Security groups to associate with the ECS tasks"
  type        = list(string)
}

variable "ecs_task_execution_role" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "target_group_arn" {
  description = "The target group of arn alb"
  type        = string
}

variable "ecr_image_url" {
  description = "The URL of the ECR image to deploy"
  type        = string
}

variable "task_cpu" {
  description = "The CPU units for the ECS task"
  type        = number
}

variable "task_memory" {
  description = "The memory (in MiB) for the ECS task"
  type        = number
}

variable "containerPort" {
  description = "The port on which the container listens"
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "The minimum healthy percent for the ECS service deployment"
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "The maximum percent for the ECS service deployment"
  type        = number
}

variable "alb_https_listener_arn" {
  description = "ARN of the HTTPS listener for the ALB"
  type        = string
}
