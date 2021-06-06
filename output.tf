
output "aws_subnet_id" {
  value = aws_subnet.main.id
}

output "ec2_public_ip" {
  value = aws_instance.myec2.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.myec2.public_dns
}

output "vpc_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}

output "public_dns" {
  value = toset([
    for record in aws_route53_record.urls : record.fqdn
  ])
}
