variable "prefix" {
  description = "A short name used as a prefix for naming and tagging all resources."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block to be assigned to the VPC."
  type        = string
}

variable "pub_sn_cidr1" {
  description = "CIDR block for the public subnet in the primary Availability Zone."
  type        = string
}

variable "az_a" {
  description = "AWS Availability Zone where the primary public subnet and resources will be deployed."
  type        = string
}

variable "pvt_sn_cidr1" {
  description = "CIDR block for the private subnet in the primary Availability Zone."
  type        = string
}

variable "ami_id" {
  description = "AMI ID used for launching EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type to be used for provisioning compute resources."
  type        = string
}

variable "pub_ec2_instance_count" {
  description = "Number of EC2 Public instances to be launched."
  type        = number
}
