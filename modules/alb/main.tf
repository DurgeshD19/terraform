resource "aws_lb" "main" {
  name               = "three-tier-alb"
  internal           = false
  load_balancer_type = "application"

  
  security_groups = [
    var.alb_security_group_id
  ]

  subnets = [
    var.public_subnet_a_id,
    var.public_subnet_b_id
  ]

  tags = {
    Name = "three-tier-alb"
  }
}
 resource "aws_lb_target_group" "main" {
    name = "three-tier-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
        path = "/"
        matcher = "200"
        interval= 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
    tags = {
        name = "three-tier-tg"
    }
 }

 resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.main.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }

 }