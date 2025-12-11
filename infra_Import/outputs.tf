output "instance_ids" {
  value = values(aws_instance.imported)[*].id
}

output "public_ips" {
  value = values(aws_instance.imported)[*].public_ip
}
