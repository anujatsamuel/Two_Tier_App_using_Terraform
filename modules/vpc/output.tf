output "region" {
 value = var.region 
}

output "project_name" {
    value = var.project_name
  
}

output "vpc_id" {
    value = aws_vpc.vpc.id
  
}

output "IGW_id" {
    value = aws_internet_gateway.IGW.id
  
}

output "subnet1a_id" {
    value = aws_subnet.subnet1a.id
  
}
output "subnet2b_id" {
    value = aws_subnet.subnet2b.id
  
}
output "subnet3a_id" {
    value = aws_subnet.subnet3a.id
  
}
output "subnet4b_id" {
    value = aws_subnet.subnet4b.id
  
}
output "subnet5a_id" {
    value = aws_subnet.subnet5a.id
  
}
output "subnet6b_id" {
    value = aws_subnet.subnet6b.id
  
}