resource "aws_lb" "kubeview-lb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_alb_ids
  subnets            = [var.subnet1_id, var.subnet2_id]
  enable_deletion_protection = false
  }

#set a listener for the load balancer

#set a listener rule for the load balancer


resource "aws_lb_target_group" "kubeview-lb" {
  name        = "${var.project_name}-alb-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    path                  = "/health"
    protocol              = "HTTP"
    matcher               = "200"
    port                  = "traffic-port"
    healthy_threshold     = 2
    unhealthy_threshold   = 2
    timeout               = 10
    interval              = 30
    }
}

# create a listener on port 80 that redirects to HTTPS on port 443
resource "aws_lb_listener" "alb_http_listener" {
    load_balancer_arn = aws_lb.kubeview-lb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type = "redirect"
        
        redirect {
            port     = 443
            protocol = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_lb_listener" "alb_https_listener" {
    load_balancer_arn = aws_lb.kubeview-lb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.certificate_arn

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.kubeview-lb.arn
    }
}
