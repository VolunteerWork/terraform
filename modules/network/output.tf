output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_app_subnet_ids" {
  description = "List of private application subnet IDs"
  value       = [for subnet in aws_subnet.private_app_subnets : subnet.id]
}

output "private_data_subnet_ids" {
  description = "List of private data subnet IDs"
  value       = [for subnet in aws_subnet.private_data_subnets : subnet.id]
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = [for nat_gateway in aws_nat_gateway.nat_gateways : nat_gateway.id]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = [for rt in aws_route_table.private_route_tables : rt.id]
}