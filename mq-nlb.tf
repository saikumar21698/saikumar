resource "aws_lb" "mq-nlb" {
  name               = "mq-nlb"
  load_balancer_type = "network"
  internal           = true
  subnets            = module.vpc.private_subnet_id
  #  security_groups    = [module.rabbitmq_cidr_sg.security_group_id]
}

resource "aws_lb_listener" "tls443" {
  load_balancer_arn = aws_lb.mq-nlb.arn
  port              = 443
  protocol          = "TLS"
  certificate_arn   = module.acm.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg443.arn
  }
}
resource "aws_lb_listener" "tls5671" {
  load_balancer_arn = aws_lb.mq-nlb.arn
  port              = 5671
  protocol          = "TLS"
  certificate_arn   = module.acm.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg5671.arn
  }
}

resource "aws_lb_target_group" "tg443" {
  name        = "tg443"
  port        = 443
  protocol    = "TLS"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

}
resource "aws_lb_target_group" "tg5671" {
  name        = "tg5671"
  port        = 5671
  protocol    = "TLS"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

}

resource "aws_lb_target_group_attachment" "tga443" {
  target_group_arn = aws_lb_target_group.tg443.arn
  target_id        = data.dns_a_record_set.mq.addrs.0

}
resource "aws_lb_target_group_attachment" "tgg5671" {
  target_group_arn = aws_lb_target_group.tg5671.arn
  target_id        = data.dns_a_record_set.mq.addrs.0

}
resource "aws_route53_record" "rabbitmq_fusion_dev_01" {
  zone_id = aws_route53_zone.main.id
  name    = "prism-sandbox-rabbitmq.${var.dns_zone}"
  type    = "CNAME"
  ttl     = 300

  #records = [ "${aws_mq_broker.rabbitmq.id}.mq.${var.aws_region}.amazonaws.com" ]
  records = [aws_lb.mq-nlb.dns_name]
}

output "rabbitmq_ip_address_used_by_nlb_target_group" {
  value = data.dns_a_record_set.mq.addrs.0
}

output "mq-elb_dns_name" {
  value       = aws_lb.mq-nlb.dns_name
  description = "The domain name of the load balancer just for RabbitMQ"
}
