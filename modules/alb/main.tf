resource "aws_lb" "application_load_balancer" {
    name = "ApplicationLoadBalancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.security_group_id]
    subnets = [var.public_subnet_id, var.public_subnet_id_alt]
    # vpc_id = var.vpc_id
    tags = {
        Name = "New CliqProperty"
    } 
}

resource "aws_lb_target_group" "target_group" {
    name = "TargetGroupHttp"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "instance"
    health_check {
        path = "/"
        protocol = "HTTP"
        interval = 30
        timeout = 5
        healthy_threshold = 5
        unhealthy_threshold = 2
    }
    tags = {
        Name = "New CliqProperty"
    } 

  
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
    target_group_arn = aws_lb_target_group.target_group.arn
    target_id = var.instance_id
    port = 80 
    depends_on = [var.instance_id]
}

resource "aws_lb_listener" "http_listener"{
    load_balancer_arn = aws_lb.application_load_balancer.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
}

resource "aws_lb_listener" "https_listener" {
    load_balancer_arn = aws_lb.application_load_balancer.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = var.certificate_arn
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
}



