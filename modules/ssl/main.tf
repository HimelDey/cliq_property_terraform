resource "aws_acm_certificate" "ssl_certificate" {
    domain_name = var.domain_name
    validation_method = "DNS"
    lifecycle {
        create_before_destroy = true
    }
    
    tags = {
        Name = "SSL Certificate for new cliqproperty"
    }
}