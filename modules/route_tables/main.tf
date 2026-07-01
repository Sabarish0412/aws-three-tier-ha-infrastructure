# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.project_name}-public-rtb"
  }
}

# Associate public route table with public subnet 1
resource "aws_route_table_association" "public_1" {
  subnet_id      = var.public_subnet_1_id
  route_table_id = aws_route_table.public.id
}

# Associate public route table with public subnet 2
resource "aws_route_table_association" "public_2" {
  subnet_id      = var.public_subnet_2_id
  route_table_id = aws_route_table.public.id
}

# Private Route Table AZ-a
resource "aws_route_table" "private_a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_1_id
  }

  tags = {
    Name = "${var.project_name}-private-rtb-a"
  }
}

# Associate private route table AZ-a with private app subnet 1
resource "aws_route_table_association" "private_app_1" {
  subnet_id      = var.private_app_subnet_1_id
  route_table_id = aws_route_table.private_a.id
}

# Associate private route table AZ-a with private db subnet 1
resource "aws_route_table_association" "private_db_1" {
  subnet_id      = var.private_db_subnet_1_id
  route_table_id = aws_route_table.private_a.id
}

# Private Route Table AZ-b
resource "aws_route_table" "private_b" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_2_id
  }

  tags = {
    Name = "${var.project_name}-private-rtb-b"
  }
}

# Associate private route table AZ-b with private app subnet 2
resource "aws_route_table_association" "private_app_2" {
  subnet_id      = var.private_app_subnet_2_id
  route_table_id = aws_route_table.private_b.id
}

# Associate private route table AZ-b with private db subnet 2
resource "aws_route_table_association" "private_db_2" {
  subnet_id      = var.private_db_subnet_2_id
  route_table_id = aws_route_table.private_b.id
}
