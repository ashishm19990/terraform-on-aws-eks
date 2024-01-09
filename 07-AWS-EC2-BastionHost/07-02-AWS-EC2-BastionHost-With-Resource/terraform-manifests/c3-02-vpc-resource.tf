resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-vpc"
    }
  )
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.vpc_public_subnets)
  cidr_block              = element(var.vpc_public_subnets, count.index)
  availability_zone       = element(var.vpc_availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    local.common_tags,
    {
      Name                                              = "${local.name}-public-subnet-${count.index + 1}"
      Type                                              = "Public Subnets"
      "kubernetes.io/role/elb"                          = 1
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    }
  )
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.vpc_private_subnets)
  cidr_block        = element(var.vpc_private_subnets, count.index)
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = merge(
    local.common_tags,
    {
      Name                                              = "${local.name}-private-subnet-${count.index + 1}"
      Type                                              = "private-subnets"
      "kubernetes.io/role/internal-elb"                 = 1
      "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    }
  )
}

resource "aws_subnet" "database_subnet" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.vpc_database_subnets)
  cidr_block        = element(var.vpc_database_subnets, count.index)
  availability_zone = element(var.vpc_availability_zones, count.index)
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-db-subnet-${count.index + 1}"
      Type = "database-subnets"
    }
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-igw"
    }
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-public-route-table"
    }
  )
}

# Route table associations for all Public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.vpc_public_subnets)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
  count      = length(var.vpc_public_subnets)
  depends_on = [aws_internet_gateway.gw]
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-nat-eip-${count.index + 1}"
    }
  )
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip[count.index].id
  count         = length(var.vpc_public_subnets)
  subnet_id     = element(aws_subnet.public_subnet[*].id, count.index)
  depends_on    = [aws_internet_gateway.gw]
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-nat-gateway-${count.index + 1}"
    }
  )
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[0].id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-private-route-table"
    }
  )
}

resource "aws_route_table_association" "private" {
  count          = length(var.vpc_private_subnets)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
