#network.tf

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = merge (var.tags, { Name = "${var.project}-vpc" } )
  /*lifecycle {
    prevent_destroy = true
    ignore_changes = [tags["LastScan"], password]
    create_before_destroy = true
  }*/

}
resource "aws_subnet" "net" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value.netnum)
  availability_zone = "${var.region}${each.value.az}"
  tags              = merge(var.tags, { Name = "${var.project}-${each.key}" })
}
moved {
  from = aws_subnet.public_a
  to   = aws_subnet.net["public-a"]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "${var.project}-igw" })
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "${var.project}-rt" })
}
resource "aws_route_table_association" "net" {
  subnet_id      = aws_subnet.net["public-a"].id
  route_table_id = aws_route_table.public.id
}

