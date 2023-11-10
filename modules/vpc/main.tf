resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "${var.project_name}-vpc"
    }
  
}
resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "${var.project_name}-igw"
    }

  
}

data "aws_availability_zones" "availabile_zones" {}

resource "aws_subnet" "subnet1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_1a_cidr
    availability_zone = data.aws_availability_zones.availabile_zones.names[0]
    map_public_ip_on_launch = true
    tags = {
      Name = "pub-sub-1a"
    }
  
}

resource "aws_subnet" "subnet2b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_2b_cidr
    availability_zone = data.aws_availability_zones.availabile_zones.names[1]
    map_public_ip_on_launch = true
    tags = {
      Name = "pub-sub-2b"
    }
  
}

resource "aws_subnet" "subnet3a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_3a_cidr
    availability_zone = data.aws_availability_zones.availabile_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
      Name = "pri-sub-3a"
    }
  
}

resource "aws_subnet" "subnet4b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_4b_cidr
    availability_zone = data.aws_availability_zones.availabile_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
      Name = "pub-sub-4b"
    }
  
}
resource "aws_subnet" "subnet5a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_5a_cidr
    availability_zone = data.aws_availability_zones.availabile_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
      Name = "pri-sub-5a"
    }
  
}

resource "aws_subnet" "subnet6b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_6b_cidr
    availability_zone = data.aws_availability_zones.availabile_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
      Name = "pub-sub-6b"
    }
  
}
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id

    }
    tags = {
        Name = "Public-rt"
    }
  
}

resource "aws_route_table_association" "pub_sub_1a_route_table_association" {
    subnet_id = aws_subnet.subnet1a.id
    route_table_id = aws_route_table.public_route_table.id
  
}

resource "aws_route_table_association" "pub_sub_2b_route_table_association" {
    subnet_id = aws_subnet.subnet2b.id
    route_table_id = aws_route_table.public_route_table.id
  
}