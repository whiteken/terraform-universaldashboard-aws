
#define VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.1.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
}

#define subnet in VPC
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.aws_availability_zone
}

#attach gateway to VPC main
resource "aws_internet_gateway" "attach_gateway" {
  vpc_id = aws_vpc.main.id
}

#add VPC outbound route to Internet via gateway
resource "aws_route" "VPCInternetRoute" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.attach_gateway.id
}