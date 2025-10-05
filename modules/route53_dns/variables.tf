variable "domain_name" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "record_name" {
  type        = string
  description = "Subdomain name for the DNS record"
}

variable "alb_dns_name" {
    description = "The DNS name of the ALB"
}

variable "alb_zone_id" {
    description = "The DNS name of the ALB"
}