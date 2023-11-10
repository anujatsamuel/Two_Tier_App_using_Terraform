resource "aws_eip" "eip-nat-a" {
       tags = {
      Name = "eip-nat-a"
    }
  
}
resource "aws_nat_gateway" "nat-a" {
    allocation_id = aws_eip.eip-nat-a.id
    subnet_id = var.subnet1a_id
    tags = {
      Name = "nat-a"
    }
  depends_on = [ var.IGW_id ]
}

resource "aws_eip" "eip-nat-b" {
       tags = {
      Name = "eip-nat-b"
    }
  
}

resource "aws_nat_gateway" "nat-b" {
    subnet_id = var.subnet2b_id
    allocation_id = aws_eip.eip-nat-b.id
    tags = {
      Name = "nat-b"
    }
    depends_on = [ var.IGW_id ]
  
}

resource "aws_route_table" "private_route_table-a" {
    vpc_id = var.vpc_id
    route    {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-a.id
    }
    tags = {
        Name = "Pri-rt-a"
    }
}

resource "aws_route_table_association" "pri-rt-a_route_table_association-subnet3a" {
     subnet_id = var.subnet3a_id
     route_table_id = aws_route_table.private_route_table-a.id
  
}
resource "aws_route_table_association" "pri-rt-a_route_table_association-subnet5a" {
     subnet_id = var.subnet5a_id
     route_table_id = aws_route_table.private_route_table-a.id
  
}

resource "aws_route_table" "private_route_table-b" {
    vpc_id = var.vpc_id
    route    {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-b.id
    }
    tags = {
        Name = "Pri-rt-b"
    }
}

resource "aws_route_table_association" "pri-rt-a_route_table_association-subnet4b" {
     subnet_id = var.subnet4b_id
     route_table_id = aws_route_table.private_route_table-b.id
  
}
resource "aws_route_table_association" "pri-rt-a_route_table_association-subnet6b" {
     subnet_id = var.subnet6b_id
     route_table_id = aws_route_table.private_route_table-b.id
  
}
