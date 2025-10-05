output "project_name" {
  description = "The project name"
  value       = var.project_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.kubeview-vpc.id
}

output "subnet1_id" {
  description = "Subnet 1 ID"
  value       = aws_subnet.public-subnet-1.id
}

output "subnet2_id" {
  description = "Subnet 2 ID"
  value       = aws_subnet.public-subnet-2.id
}

output "internet_gateway" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.kubeview-igw.id
}