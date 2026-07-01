# Elastic IPs for NAT Gateways
resource "aws_eip" "nat_1" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-1"
  }
}

resource "aws_eip" "nat_2" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-2"
  }
}

# NAT Gateway in AZ-a (public subnet 1)
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = var.public_subnet_1_id

  tags = {
    Name = "${var.project_name}-nat-gw-1"
  }

  depends_on = [var.igw_id]
}

# NAT Gateway in AZ-b (public subnet 2)
resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = var.public_subnet_2_id

  tags = {
    Name = "${var.project_name}-nat-gw-2"
  }

  depends_on = [var.igw_id]
}
