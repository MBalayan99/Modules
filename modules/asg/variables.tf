variable "ami" {
  description = "AMI for the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "instance_sg_id" {
  description = "Security group for the instances"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}
