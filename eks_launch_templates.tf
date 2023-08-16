# Read this for when we are ready to deploy with our own AMIs: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/modules/node_groups/launch_template.tf#L62

# variable "eks_node_volume_size" { default = "25" }
# variable "eks_node_volume_type" { default = "gp2" }
# variable "eks_node_volume_delete_on_termination" { default = true }
# variable "eks_node_volume_encrypted" { default = true }
# variable "eks_node_device_name" { default = "/dev/xvda" }
# variable "eks_ami_id" { default = null }
# variable "eks_ami_id_new" { default = null }

/*
resource "aws_launch_template" "eks_spot_instance_eu_west_1a" {
  name                   = "spot.eks.${var.dns_zone}-${var.aws_region}a"
  description            = "${local.environment} Spot Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.large"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "spot.eks.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}



resource "aws_launch_template" "eks_spot_instance_eu_west_1b" {
  name                   = "spot.eks.${var.dns_zone}-${var.aws_region}b"
  description            = "${local.environment} Spot Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.large"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )


  placement {
    availability_zone = "${var.aws_region}b"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "spot.eks.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}



resource "aws_launch_template" "eks_on_demand_instance_eu_west_1a" {
  name                   = "on-demand.eks.${var.dns_zone}-${var.aws_region}a"
  description            = "${local.environment} On-Demand Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.large"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=on-demand' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "on-demand.eks.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}

resource "aws_launch_template" "eks_on_demand_instance_eu_west_1b" {
  name                   = "on-demand.eks.${var.dns_zone}-${var.aws_region}b"
  description            = "${local.environment} On-Demand Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.large"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
echo "`date`: before bootstrap">>/tmp/user-data.txt
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=on-demand' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}
echo "`date`: after bootstrap">>/tmp/user-data.txt
#sleep 2m && jq 'del(."evictionHard")' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json && echo "`date`: remove evictionHard">>/tmp/user-data.txt &
sleep 2m && jq '. |= . + {"evictionHard": { "memory.available": "10%", "nodefs.available": "10%", "nodefs.inodesFree": "5%" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json && echo "`date`: Adding evictionHard">>/tmp/user-data.txt && service kubelet restart && echo "`date`: restart service">>/tmp/user-data.txt &
jq '. |= . + {"evictionSoft": { "memory.available": "20%", "nodefs.available": "13%", "nodefs.inodesFree": "8%" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json
jq '. |= . + {"evictionSoftGracePeriod": {"memory.available": "5m", "nodefs.available": "2m", "nodefs.inodesFree": "2m" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json
#jq '. |= . + {"evictionHard": { "memory.available": "10%", "nodefs.available": "10%", "nodefs.inodesFree": "5%" }}' /etc/kubernetes/kubelet/kubelet-config.json > /tmp/temp.json && mv /tmp/temp.json /etc/kubernetes/kubelet/kubelet-config.json && echo "`date`: Adding evictionHard">>/tmp/user-data.txt
#sync -d /etc/kubernetes/kubelet/kubelet-config.json
#service kubelet restart && echo "`date`: restart service">>/tmp/user-data.txt


--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}b"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "on-demand.eks.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}

resource "aws_launch_template" "eks_spot_instance_m5_xlarge_eu_west_1a" {
  name                   = "spot.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}a"
  description            = "${local.environment} Spot Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.xlarge"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "spot.eks.m5.xlarge.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}

resource "aws_launch_template" "eks_spot_instance_m5_xlarge_eu_west_1b" {
  name                   = "spot.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}b"
  description            = "${local.environment} Spot Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.xlarge"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}b"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "spot.eks.m5.xlarge.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}

resource "aws_launch_template" "eks_on_demand_instance_m5_xlarge_eu_west_1a" {
  name                   = "on-demand.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}a"
  description            = "${local.environment} On-Demand Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.xlarge"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=on-demand' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "on-demand.eks.m5.xlarge.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}

resource "aws_launch_template" "eks_on_demand_instance_m5_xlarge_eu_west_1b" {
  name                   = "on-demand.eks.m5.xlarge.${var.dns_zone}-${var.aws_region}b"
  description            = "${local.environment} On-Demand Instance Launch Template"
  #update_default_version = true
  image_id               = var.eks_ami_id
  instance_type          = "m5.xlarge"

  key_name = aws_key_pair.provisioning.key_name

  block_device_mappings {
    device_name = var.eks_node_device_name

    ebs {
      volume_size           = var.eks_node_volume_size
      volume_type           = var.eks_node_volume_type
      delete_on_termination = var.eks_node_volume_delete_on_termination
      encrypted             = var.eks_node_volume_encrypted
      kms_key_id            = data.terraform_remote_state.shared_services.outputs.kms_ebs_fusion_prod_arn
    }
  }

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh bd-fusion-prod --kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=on-demand' --b64-cluster-ca ${module.eks.cluster_certificate_authority_data} --apiserver-endpoint ${module.eks.cluster_endpoint}

--//--
  EOF
  )

  placement {
    availability_zone = "${var.aws_region}b"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "on-demand.eks.m5.xlarge.${var.dns_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [image_id]
  }
}

*/
