variable "region" {
  description = "ID element. Usually an abbreviation for the organization name."
  type        = string
}

variable "label_context" {
  description = "Context to pass into null-label for generating tags"
  type        = any
}

variable "mc_port" {
  description = "Minecraft TCP port"
  type        = number
  default     = 25565
}

variable "allowed_cidrs" {
  description = "Allowed CIDR blocks to the server - defaults to universe"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ec2_instance_type" {
  description = "EC2 instance size to run server on. Defaults to t2.large."
  type        = string
  default     = "t2.large"
}

variable "ec2_ami" {
  description = "AMI to use for the ec2 instance. Defaults to ubuntu 22.04 LTS x86"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}
