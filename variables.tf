variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy to"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR for public subnet 1"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR for public subnet 2"
}

variable "public_subnet_1_az" {
  type        = string
  description = "Availability zone for subnet 1"
}

variable "public_subnet_2_az" {
  type        = string
  description = "Availability zone for subnet 2"
}

variable "domain_name" {
  type        = string
  description = "Domain name for Route 53 and ACM"
}

variable "record_name" {
  type        = string
  description = "Subdomain for DNS record"
}

variable "ecr_image_url" {
  type        = string
  description = "ECR image URL for ECS"
}

variable "task_cpu" {
  type        = string
  description = "CPU units for the ECS task"
}

variable "task_memory" {
  type        = string
  description = "Memory (in MB) for the ECS task"
}

variable "containerPort" {
  type        = number
  description = "Container port exposed by the task"
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  type        = number
  description = "Minimum healthy percentage for ECS deployment"
}

variable "ecs_task_deployment_maximum_percent" {
  type        = number
  description = "Maximum percent of ECS tasks during deployment"
}
