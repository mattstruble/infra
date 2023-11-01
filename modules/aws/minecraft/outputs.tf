output "vpc_id" {
  value = local.vpc_id
}

output "subnet_id" {
  value = local.subnet_id
}

output "public_ip" {
  value = aws_instance.ec2_minecraft.public_ip
}

output "id" {
  value = aws_instance.ec2_minecraft.id
}

output "public_key_openssh" {
  value     = tls_private_key.tls_key.public_key_openssh
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.tls_key.public_key_pem
  sensitive = true
}

output "private_key" {
  value     = tls_private_key.tls_key.private_key_pem
  sensitive = true
}

resource "local_file" "private_key" {
  content              = tls_private_key.tls_key.private_key_pem
  filename             = "./${module.ec2_label.id}-private-key.pem"
  directory_permission = "0700"
  file_permission      = "0700"
}


output "ec2_instance_profile" {
  value = aws_iam_instance_profile.mc_role.name
}

output "minecraft_server" {
  value = "${aws_instance.ec2_minecraft.public_ip}:${var.mc_port}"
}
