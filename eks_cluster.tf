variable "eks_volume_size" { default = "25" }

module "eks" {
  source                                         = "terraform-aws-modules/eks/aws"
  version                                        = "17.10.0"
  cluster_name                                   = var.account_name
  cluster_version                                = "1.23"
  cluster_endpoint_private_access_cidrs          = local.eks_allowed_cidr_blocks
  cluster_endpoint_private_access_sg             = [aws_security_group.eks.id]
  cluster_service_ipv4_cidr                      = "172.20.0.0/20"
  vpc_id                                         = module.vpc.vpc_id
  subnets                                        = module.vpc.private_subnet_ids
  map_roles                                      = local.eks_map_roles
  write_kubeconfig                               = false
  cluster_endpoint_private_access                = true
  cluster_endpoint_public_access                 = false
  cluster_create_endpoint_private_access_sg_rule = true
  wait_for_cluster_timeout                       = 0
  enable_irsa                                    = true
  # cluster_addons = {
  #   aws-ebs-csi-driver = {
  #     resolve_conflicts = "OVERWRITE"
  #     service_account_role_arn = aws_iam_role.ebs_csi_controller_role.arn
  #     version = "v1.18.0-eksbuild.1"
  #     settings = {
  #       enableVolumeScheduling = true
  #       enableVolumeResizing = true
  #       enableVolumeSnapshot = true
  #       encryption = {
  #         kmskeyId = aws_kms_key.ebs_key.key_id
  #         encrypted = true
  #       }
  #     }
  #   }
  # }

  cluster_encryption_config = [
    {
      provider_key_arn = data.terraform_remote_state.shared_services.outputs.kms_eks_fusion_sandbox_arn
      resources        = ["secrets"]
    }
  ]
  

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = {
    Name = "${var.account_name}"
  }
}



resource "aws_security_group" "eks" {
  name        = "${var.account_name}-eks-sg"
  description = "Allow EKS traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.eks_allowed_cidr_blocks
    description = "Allow ${var.account_name} EKS 443 access"
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


resource "aws_iam_role_policy_attachment" "attach_session_manager_permissions_policy_to_eks_cluster_role" {
  role       = module.eks.worker_iam_role_name
  policy_arn = aws_iam_policy.session_manager_permissions_policy.arn

  depends_on = [module.eks]
}
