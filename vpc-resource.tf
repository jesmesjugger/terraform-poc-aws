resource "aws_vpc" "main-poc" {
  cidr_block       = "${var.vpc_cidr_ip}"
  instance_tenancy = "default"

  tags = {
    Name = "main-poc"
  }
}

//subnet

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main-poc.id
  cidr_block = "${var.vpc_cidr_ip_subnet[0]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

//subnet2

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.main-poc.id
  cidr_block = "${var.vpc_cidr_ip_subnet[1]}"

  tags = {
    Name = "private-subnet"
  }
}

/** internet gateway
*/
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-poc.id

  tags = {
    Name = "internet-gw"
  }
}

//eip
resource "aws_eip" "nat" {
  vpc      = true
}

//nat-gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = "${aws_subnet.private-subnet.id}"

  tags = {
    Name = "gw NAT"
  }
}

//public-routable

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main-poc.id

  route {
    cidr_block = "${var.route_internet}"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rtb"
  }
}

//private-routable

resource "aws_route_table" "r2" {
  vpc_id = aws_vpc.main-poc.id

  route {
    cidr_block = "${var.route_internet}"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-rtb"
  }
}


//rtb-association-public
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.r.id
}

//rtb-association-private
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.r2.id
}