variable "namespace" {
  description = "ID element. Usually an abbreviation for the organization name."
  type        = string
}

variable "environment" {
  description = "ID element. Usually used for the region."
  type        = string
}

variable "name" {
  description = "ID element. Usually the component or solution name."
  type        = string
}

variable "tags" {
  description = "Additional tags (e.g. {'BusinessUnit': 'XYZ'})"
  type        = map(string)
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
  description = "AMI to use for the ec2 instance"
  type        = string
  default     = "ami-0aa2b7722dc1b5612"
}
