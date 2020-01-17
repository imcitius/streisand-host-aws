resource "aws_vpc" "streisand" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "streisand vpc"
  }
}

resource "aws_internet_gateway" "streisand_gw" {
  vpc_id = aws_vpc.streisand.id
}

resource "aws_subnet" "streisand" {
  vpc_id     = aws_vpc.streisand.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

  depends_on = [
    aws_internet_gateway.streisand_gw
  ]

  tags = {
    Name = "streisand subnet"
  }
}

resource "aws_default_route_table" "route_table" {

  default_route_table_id = aws_vpc.streisand.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.streisand_gw.id
  }
  
  tags = {
    Name = "streisand route table"
  }

}
