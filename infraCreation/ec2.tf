# Define the EC2 instance in Public subnet's
resource "aws_instance" "pub-ser" {
  count                  = var.pub_subnet_count
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = "keypair" # It must be avaialble in your aws account - within the region.
  subnet_id              = aws_subnet.pub_sn1.id
  vpc_security_group_ids = ["${aws_security_group.WebSG.id}"]
  tags = {
    Name = "TF-${count.index + 1}-Pub-Machine"
  }
}
