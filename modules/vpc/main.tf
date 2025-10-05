resource "aws_vpc" "kubeview-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.project_name}-vpc"
  }
}
#maybe data source to get all azs in region avalibility_zone 
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.kubeview-vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.public_subnet_1_az
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.kubeview-vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.public_subnet_2_az
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "kubeview-igw" {
  vpc_id = aws_vpc.kubeview-vpc.id
  tags = {
    Name = "${var.project_name}-vpc-IGW"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.kubeview-vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kubeview-igw.id
}

resource "aws_route_table_association" "public-subnet-1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}