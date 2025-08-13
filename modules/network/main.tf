
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-vpc"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# Internet Gateway
##########################################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-igw"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# Public Subnets
##########################################
resource "aws_subnet" "public_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone   = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name                      = "${var.project_name}-${var.env}-public-subnet${count.index}"
      Environment               = var.env
    },
    var.tags
  )
}

##########################################
# Private Subnets for Applications
##########################################
resource "aws_subnet" "private_app_subnets" {
  count              = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block              = var.private_app_subnet_cidrs[count.index]
  availability_zone   = var.availability_zones[count.index]

  tags = merge(
    {
      Name                  = "${var.project_name}-${var.env}-private-app-subnet${count.index}"
      Environment      = var.env
    },
    var.tags
  )
}

##########################################
# Private Subnets for Data
##########################################
resource "aws_subnet" "private_data_subnets" {
  count              = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block              = var.private_data_subnet_cidrs[count.index]
  availability_zone   = var.availability_zones[count.index]

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-private-data-subnet${count.index}"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# Elastic IPs for NAT Gateway
##########################################
resource "aws_eip" "nat_eips" {
  count  = length(var.availability_zones)
  domain = "vpc"

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-eip-az${count.index}"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# NAT Gateways
##########################################
resource "aws_nat_gateway" "nat_gateways" {
  count  = length(var.availability_zones)
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-nat-gateway-az${count.index}"
      Environment = var.env
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.main]
}

##########################################
# Route Tables
##########################################
# Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-public-rt"
      Environment = var.env
    },
    var.tags
  )
}

# Private route tables
resource "aws_route_table" "private_route_tables" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
  }

  tags = merge(
    {
      Name        = "${var.project_name}-${var.env}-private-rt-az${count.index}"
      Environment = var.env
    },
    var.tags
  )
}

##########################################
# Route Table Associations
##########################################
# Public subnets associations
resource "aws_route_table_association" "public_subnet_associations" {
  count  = length(var.availability_zones)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private app subnets associations
resource "aws_route_table_association" "private_app_subnet_associations" {
  count  = length(var.availability_zones)
  subnet_id      = aws_subnet.private_app_subnets[count.index].id
  route_table_id = aws_route_table.private_route_tables[count.index].id
}

# Private data subnets associations
resource "aws_route_table_association" "private_data_subnet_associations" {
  count  = length(var.availability_zones)
  subnet_id      = aws_subnet.private_data_subnets[count.index].id
  route_table_id = aws_route_table.private_route_tables[count.index].id
}