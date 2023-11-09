data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = local.vpc_id
}

data "aws_caller_identity" "aws" {}

data "aws_subnet" "selected" {
  id = local.subnet_id
}

data "external" "current_ip" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}

locals {
  vpc_id    = data.aws_vpc.default.id
  subnet_id = sort(data.aws_subnet_ids.default.ids)[0]
}

module "ec2_label" {
  source = "git::https://github.com/cloudposse/terraform-null-label.git?ref=main"

  context = var.label_context
}


# Security Group
resource "aws_security_group" "ec2_security_group" {
  name   = module.ec2_label.id
  tags   = module.ec2_label.tags
  vpc_id = local.vpc_id

  ingress {
    description = "Enable internal/local ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.current_ip.result.ip}/32"]
  }

  ingress {
    description = "Minecraft IP range"
    from_port   = var.mc_port
    to_port     = var.mc_port
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidrs}"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.allowed_cidrs]
  }
}

# EC2 SSH Key Pair
resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "${module.ec2_label.id}-ssh-key"
  public_key = tls_private_key.tls_key.public_key_openssh
  tags       = module.ec2_label.tags
}

resource "aws_iam_instance_profile" "mc_role" {
  name = "${module.ec2_label.id}-profile"
  tags = module.ec2_label.tags
}

# AWS Instance
resource "aws_instance" "ec2_minecraft" {
  key_name             = aws_key_pair.ec2_key.key_name
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.mc_role.id
  ami                  = var.ec2_ami

  subnet_id                   = local.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true
  monitoring                  = true

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = module.ec2_label.tags
}

# EBS Volume
resource "aws_ebs_volume" "mc_volume" {
  availability_zone = data.aws_subnet.selected.availability_zone
  size              = 8
  type              = "gp3"
  tags              = module.ec2_label.tags
}

resource "aws_volume_attachment" "mc_vol_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.mc_volume.id
  instance_id = aws_instance.ec2_minecraft.id
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "active_connections" {
  alarm_name        = "${module.ec2_label.id}-network-alarm"
  alarm_description = "Detects when there hasn't been any inbound network traffic and stops the ec2 instance."

  statistic           = "Average"
  comparison_operator = "LessThanThreshold"
  period              = 300
  threshold           = 2500
  unit                = "Bytes"
  evaluation_periods  = 3
  namespace           = "AWS/EC2"
  metric_name         = "NetworkIn"
  alarm_actions       = ["arn:aws:automate:${var.region}:ec2:stop"]
  dimensions          = { InstanceId = aws_instance.ec2_minecraft.id }
  tags                = module.ec2_label.tags
}
