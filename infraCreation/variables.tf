variable "prefix" {
  description = "What type of module"
  type        = string
}

variable "instance_tenancy" {
  description = "instance_tenancy Type"
  type        = string
}

variable "web_security_group_id" {
  description = "ID of the web security group"
  type        = string
  default     = null # Optional: allows empty values
}

variable "vpc_cidr_block" {
  description = "VPC Block CIDR Range"
  type        = string
}

variable "pub_sn_cidr1" {
  description = "Public Availability Zones"
  type        = string
}

variable "az_a" {
  description = "Public Availability Zones"
  type        = string
}

variable "pvt_sn_cidr1" {
  description = "Private Availability Zone"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "environment" {
  description = "Type of Environment"
  type        = string
}

variable "pub_subnet_count" {
  description = "How many EC2 Instances need to provision: "
  type        = number
}
