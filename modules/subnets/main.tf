# Public Subnets (Web Tier)
resource "aws_subnet" "public_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-1"
    Tier = "Public"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"
    Tier = "Public"
  }
}

# Private Subnets (Application Tier)
resource "aws_subnet" "private_app_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.project_name}-private-app-subnet-1"
    Tier = "Private-App"
  }
}

resource "aws_subnet" "private_app_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.project_name}-private-app-subnet-2"
    Tier = "Private-App"
  }
}

# Private Subnets (Database Tier)
resource "aws_subnet" "private_db_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_db_subnet_1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.project_name}-private-db-subnet-1"
    Tier = "Private-DB"
  }
}

resource "aws_subnet" "private_db_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_db_subnet_2_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.project_name}-private-db-subnet-2"
    Tier = "Private-DB"
  }
}
