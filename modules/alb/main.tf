resource "aws_lb" "application_load_balancer" {
    name = "ApplicationLoadBalancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.custom_sg.id]
    subnets = [aws_subnet.public_subnet.id]
    vpc_id = aws_vpc.custom_vpc.id
    tags = {
        Name = "ApplicationLoadBalancer"
    } 
}

resource "aws_lb_target_group" "target_group" {
    name = "TargetGroupHttp"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.custom_vpc.id
    target_type = "instance"
    health_check {
        path = "/"
        protocol = "HTTP"
        interval = 30
        timeout = 5
        healthy_threshold = 5
        unhealthy_threshold = 2
    }
  
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
    target_group_arn = aws_lb_target_group.target_group.arn
    target_id = aws_instance.web_server.id
    port = 80 
    depends_on = [aws_instance.web_server]
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
    certificate_arn = aws_acm_certificate.ssl_certificate.arn
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
}



