#
# VPC Resources
#  * VPC
#  * Subnets (Public)
#  * Internet Gateway
#  * Route Table
#

# VPC
resource "aws_vpc" "tsp-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name                                      = "tsp-eks-node"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}

# Public Subnets (2 AZs)
resource "aws_subnet" "tsp-vpc" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.tsp-vpc.id

  tags = {
    Name                                      = "tsp-eks-node-${count.index}"
    "kubernetes.io/cluster/${var.cluster-name != "" ? var.cluster-name : "tsp-cluster-${terraform.workspace}"}" = "shared"
    "kubernetes.io/role/elb"                 = "1"  # Needed for public ELB access
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tsp-vpc" {
  vpc_id = aws_vpc.tsp-vpc.id

  tags = {
    Name = "tsp-vpc"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "tsp-vpc" {
  vpc_id = aws_vpc.tsp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tsp-vpc.id
  }

  tags = {
    Name = "tsp-vpc-public-rt"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "tsp-vpc" {
  count = 2

  subnet_id      = aws_subnet.tsp-vpc[count.index].id
  route_table_id = aws_route_table.tsp-vpc.id
}
