variable "mq_allowed_cidr_blocks" {
  type    = list(any)
  default = []
}

resource "aws_mq_broker" "rabbitmq" {
  broker_name = "rabbitmq"

  engine_type        = "RabbitMQ"
  engine_version     = "3.9.16"
  host_instance_type = "mq.m5.large"
  deployment_mode    = "CLUSTER_MULTI_AZ"
  security_groups    = [module.rabbitmq_cidr_sg.security_group_id]
  subnet_ids         = module.vpc.private_subnet_id
  user {
    username = local.mq_username
    password = random_password.rabbitmq_password.result
  }
}
resource "random_password" "rabbitmq_password" {
  length  = 12
  special = false
}
module "rabbitmq_cidr_sg" {
  source = "../../../infrastructure/terraform/sg-v1.0"

  name   = "rabbitmq-external-traffic-prism-dev"
  vpc_id = module.vpc.vpc_id
  ports = [
    443,
    5671
  ]
  cidr_blocks = concat(var.mq_allowed_cidr_blocks, var.private_subnet_cidrs, var.shared_services_cidr_blocks, var.internal_subnet_cidrs)
}

provider "rabbitmq" {
  endpoint = aws_mq_broker.rabbitmq.instances.0.console_url
  username = local.mq_username
  password = random_password.rabbitmq_password.result
}


output "rabbitmq_endpoint" {
  value = aws_mq_broker.rabbitmq.instances.0.endpoints.0
}
output "rabbitmq_web_console_url" {
  value = aws_mq_broker.rabbitmq.instances.0.console_url
}

