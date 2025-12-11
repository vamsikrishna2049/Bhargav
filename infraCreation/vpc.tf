# Creating VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# Creating - Public subnets in AZ-1
resource "aws_subnet" "pub_sn1" {
  vpc_id                  = aws_vpc.main.id  # Reference to the VPC ID
  cidr_block              = var.pub_sn_cidr1 # CIDR block for the subnet
  availability_zone       = var.az_a         # Availability Zone
  map_public_ip_on_launch = true             # Map public IP on launch
  tags = {
    Name = "${var.prefix}-pub-sn-1" # Tag for the subnet
  }
}

# Creating - Private subnets in AZ-1
resource "aws_subnet" "pvt_sn1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pvt_sn_cidr1
  availability_zone       = var.az_a
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.prefix}-pvt-sn-1"
  }
}

#Creating - IGW
resource "aws_internet_gateway" "igw" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

# Creating Elastic IP for NAT Gateway
resource "aws_eip" "eip1" {
  tags = {
    Name = "${var.prefix}-eip1"
  }
}

#NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.pub_sn1.id
  tags = {
    Name = "${var.prefix}-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

#Creating - Routing Tables -Public
resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-pub-rt"
  }
}

#Creating - Routing Tables -Private
resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.prefix}-pvt-rt"
  }
}

#Edit Subnet Associations for Public Subnet-1
resource "aws_route_table_association" "pub_sn_ass1" {
  subnet_id      = aws_subnet.pub_sn1.id
  route_table_id = aws_route_table.pub.id
}

#Edit Subnet Associations for Private Subnet-1
resource "aws_route_table_association" "pvt_sn_ass1" {
  subnet_id      = aws_subnet.pvt_sn1.id
  route_table_id = aws_route_table.pvt.id
}

# Creating - WebServer Security Group
resource "aws_security_group" "WebSG" {
  vpc_id = aws_vpc.main.id
  name   = "${var.prefix}_web_sg"
  # description = "Created by using TerraForm"

  # Edit inbound rules
  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Works for Ping"
    from_port   = -1 # ICMP doesn't have ports, so use -1
    to_port     = -1 # ICMP doesn't have ports, so use -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Allow ICMP traffic from any source
  }

  ingress {
    description = "Allow HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Edit outbound rules
  egress {
    description = "Allow all Outbound Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}_web_sg"
  }
}

# Network Access List
resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.pub_sn_cidr1
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.pub_sn_cidr1
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "${var.prefix}_web_sg"
  }
}
