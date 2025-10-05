resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"


  tags = {
    Environment = "abdull-kubeview-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#arn cert in here and call it to alb certificate_arn