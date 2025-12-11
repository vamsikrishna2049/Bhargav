resource "aws_instance" "imported" {
  for_each = var.instance_ids

  ami                    = each.value["ami"]
  instance_type          = each.value["instance_type"]
  subnet_id              = each.value["subnet_id"]
  vpc_security_group_ids = each.value["security_groups"]
}
