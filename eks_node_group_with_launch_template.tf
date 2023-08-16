locals {
  node_groups = {

    "spot-m5-large-eu-west-1a" = {
      "node_group_name" = "spot-m5-large-eu-west-1a",
      "capacity_type"   = "SPOT",
      "subnet"          = data.aws_subnets.internal_a.ids,
      "launch_template_profile" = {
        name              = "spot.eks.${var.dns_zone}-${var.aws_region}a"
        availability_zone = "${var.aws_region}a"
        description       = "${local.environment} Spot Instance Launch Template"
        instance_type     = "m5.large"
        tags_name         = "spot.eks.${var.dns_zone}"
      }
      # desired_size = 4
    },
    "spot-m5-large-eu-west-1b" = {
      "node_group_name" = "spot-m5-large-eu-west-1b",
      "capacity_type"   = "SPOT",
      "subnet"          = data.aws_subnets.internal_b.ids,
      "launch_template_profile" = {
        name              = "spot.eks.${var.dns_zone}-${var.aws_region}b"
        availability_zone = "${var.aws_region}b"
        description       = "${local.environment} Spot Instance Launch Template"
        instance_type     = "m5.large"
        tags_name         = "spot.eks.${var.dns_zone}"
      }
    },
    "spot-m5-large-eu-west-1c" = {
      "node_group_name" = "spot-m5-large-eu-west-1c",
      "capacity_type"   = "SPOT",
      "subnet"          = data.aws_subnets.internal_c.ids,
      "launch_template_profile" = {
        name              = "spot.eks.${var.dns_zone}-${var.aws_region}c"
        availability_zone = "${var.aws_region}c"
        description       = "${local.environment} Spot Instance Launch Template"
        instance_type     = "m5.large"
        tags_name         = "spot.eks.${var.dns_zone}"
      }
    },    

    "on-demand-m5-large-eu-west-1a" = {
      "node_group_name" = "on-demand-m5-large-eu-west-1a",
      "capacity_type"   = "ON_DEMAND",
      "subnet"          = data.aws_subnets.internal_a.ids,
      "launch_template_profile" = {
        name              = "on-demand.eks.${var.dns_zone}-${var.aws_region}a"
        availability_zone = "${var.aws_region}a"
        description       = "${local.environment} On-Demand Instance Launch Template"
        instance_type     = "m5.large"
        tags_name         = "on-demand.eks.${var.dns_zone}"
      }
      min_size = 1
    },

    "on-demand-m5-large-eu-west-1b" = {
      "node_group_name" = "on-demand-m5-large-eu-west-1b",
      "capacity_type"   = "ON_DEMAND",
      "subnet"          = data.aws_subnets.internal_b.ids,
      "launch_template_profile" = {
        name              = "on-demand.eks.${var.dns_zone}-${var.aws_region}b"
        availability_zone = "${var.aws_region}b"
        description       = "${local.environment} On-Demand Instance Launch Template"
        instance_type     = "m5.large"
        tags_name         = "on-demand.eks.${var.dns_zone}"
      }
      # min_size = 1
    },

    "on-demand-m5-large-eu-west-1c" = {
      "node_group_name" = "on-demand-m5-large-eu-west-1c",
      "capacity_type"   = "ON_DEMAND",
      "subnet"          = data.aws_subnets.internal_c.ids,
      "launch_template_profile" = {
        name              = "on-demand.eks.${var.dns_zone}-${var.aws_region}c"
        availability_zone = "${var.aws_region}c"
        description       = "${local.environment} On-Demand Instance Launch Template"
        instance_type     = "m5.large"
        tags_name         = "on-demand.eks.${var.dns_zone}"
      }
    },    

    "spot-m5-xlarge-eu-west-1a" = {
      "node_group_name" = "spot-m5-xlarge-eu-west-1a",
      "capacity_type"   = "SPOT",
      "subnet"          = data.aws_subnets.internal_a.ids,
      "launch_template_profile" = {
        name              = "spot.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}a"
        availability_zone = "${var.aws_region}a"
        description       = "${local.environment} Spot Instance Launch Template"
        instance_type     = "m5.xlarge"
        tags_name         = "spot.eks.m5.xlarge.${var.dns_zone}"
      }
    },
    "spot-m5-xlarge-eu-west-1b" = {
      "node_group_name" = "spot-m5-xlarge-eu-west-1b",
      "capacity_type"   = "SPOT",
      "subnet"          = data.aws_subnets.internal_b.ids,
      "launch_template_profile" = {
        name              = "spot.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}b"
        availability_zone = "${var.aws_region}b"
        description       = "${local.environment} Spot Instance Launch Template"
        instance_type     = "m5.xlarge"
        tags_name         = "spot.eks.m5.xlarge.${var.dns_zone}"
      }
    },
    "spot-m5-xlarge-eu-west-1c" = {
      "node_group_name" = "spot-m5-xlarge-eu-west-1c",
      "capacity_type"   = "SPOT",
      "subnet"          = data.aws_subnets.internal_c.ids,
      "launch_template_profile" = {
        name              = "spot.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}c"
        availability_zone = "${var.aws_region}c"
        description       = "${local.environment} Spot Instance Launch Template"
        instance_type     = "m5.xlarge"
        tags_name         = "spot.eks.m5.xlarge.${var.dns_zone}"
      }
    },    
    "on-demand-m5-xlarge-eu-west-1a" = {
      "node_group_name" = "on-demand-m5-xlarge-eu-west-1a",
      "capacity_type"   = "ON_DEMAND",
      "subnet"          = data.aws_subnets.internal_a.ids,
      "launch_template_profile" = {
        name              = "on-demand.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}a"
        availability_zone = "${var.aws_region}a"
        description       = "${local.environment} On-Demand Instance Launch Template"
        instance_type     = "m5.xlarge"
        tags_name         = "on-demand.eks.m5.xlarge.${var.dns_zone}"
      }
    },
    "on-demand-m5-xlarge-eu-west-1b" = {
      "node_group_name" = "on-demand-m5-xlarge-eu-west-1b",
      "capacity_type"   = "ON_DEMAND",
      "subnet"          = data.aws_subnets.internal_b.ids,
      "launch_template_profile" = {
        name              = "on-demand.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}b"
        availability_zone = "${var.aws_region}b"
        description       = "${local.environment} On-Demand Instance Launch Template"
        instance_type     = "m5.xlarge"
        tags_name         = "on-demand.eks.m5.xlarge.${var.dns_zone}"
      }
    },
    "on-demand-m5-xlarge-eu-west-1c" = {
      "node_group_name" = "on-demand-m5-xlarge-eu-west-1c",
      "capacity_type"   = "ON_DEMAND",
      "subnet"          = data.aws_subnets.internal_c.ids,
      "launch_template_profile" = {
        name              = "on-demand.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}c"
        availability_zone = "${var.aws_region}c"
        description       = "${local.environment} On-Demand Instance Launch Template"
        instance_type     = "m5.xlarge"
        tags_name         = "on-demand.eks.m5.xlarge.${var.dns_zone}"
      }
    },    

  }
  kubernetes_lifecycle = {
    "SPOT"      = "spot",
    "ON_DEMAND" = "on-demand"
  }
}


resource "aws_launch_template" "launch_templates" {
  for_each    = local.node_groups
  name        = each.value.launch_template_profile.name
  description = each.value.launch_template_profile.description
  #update_default_version = true
  image_id      = var.eks_ami_id
  instance_type = each.value.launch_template_profile.instance_type

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_sandbox_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -x
sed -i 'N;1 a set -x' /etc/eks/bootstrap.sh
/etc/eks/bootstrap.sh ${var.account_name} --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=${lookup(local.kubernetes_lifecycle, each.value.capacity_type)}' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}
sleep 2m && jq '. |= . + {"evictionHard": { "memory.available": "10%", "nodefs.available": "10%", "nodefs.inodesFree": "5%" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json && service kubelet restart && echo "`date` : hardeviction--restarted service">>/tmp/user-data.txt &
jq '. |= . + {"evictionSoft": { "memory.available": "20%", "nodefs.available": "13%", "nodefs.inodesFree": "8%" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json && echo "`date` : softeviction">>/tmp/user-data.txt
jq '. |= . + {"evictionSoftGracePeriod": {"memory.available": "5m", "nodefs.available": "2m", "nodefs.inodesFree": "2m" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json && echo "`date` : grace time">>/tmp/user-data.txt
cat /tmp/user-data.txt

--//--
  EOF
  )

  placement {
    availability_zone = each.value.launch_template_profile.availability_zone
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = each.value.launch_template_profile.tags_name
    }
  }

  lifecycle {
    create_before_destroy = true
    # ignore_changes        = [image_id]
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }
}


resource "aws_eks_node_group" "node_groups" {
  for_each        = local.node_groups
  cluster_name    = var.account_name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.eks-cluster-ng.arn
  subnet_ids      = each.value.subnet
  capacity_type   = each.value.capacity_type
  tags = each.value.capacity_type != "ON_DEMAND" ? {
    Name                                                                           = "${var.account_name}"
    "k8s.io/cluster-autoscaler/node-template/label/topology.kubernetes.io/zone"    = each.value.launch_template_profile.availability_zone
    "k8s.io/cluster-autoscaler/node-template/label/eks.amazonaws.com/capacityType" = each.value.capacity_type
    } : {
    Name                                                                           = "${var.account_name}"
    "k8s.io/cluster-autoscaler/node-template/label/topology.kubernetes.io/zone"    = each.value.launch_template_profile.availability_zone
    "k8s.io/cluster-autoscaler/node-template/label/eks.amazonaws.com/capacityType" = each.value.capacity_type
    "k8s.io/cluster-autoscaler/node-template/taint/capacityType"                   = "ON_DEMAND:PreferNoSchedule"
  }

  scaling_config {
    desired_size = max(try(each.value.desired_size, 0), try(each.value.min_size, 0))
    max_size     = try(each.value.max_size, 20)
    min_size     = try(each.value.min_size, 0)
  }

  launch_template {
    name    = each.value.launch_template_profile.name
    version = aws_launch_template.launch_templates[each.key].latest_version
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-ng-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-cluster-ng-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-cluster-ng-AmazonEC2ContainerRegistryReadOnly,
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size,
    ]
    create_before_destroy = true
  }
}
