output "security_group_ecs_ids" {
  description = "Security group IDs for ECS tasks"
  value       = [aws_security_group.ecs_sg.id]
}

output "security_group_alb_ids" {
  description = "Security group IDs for ALB"
  value       = [aws_security_group.alb_sg.id]
}