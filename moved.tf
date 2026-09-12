# moved.tf

moved {
  from = aws_subnet.this
  to   = aws_subnet.net
}
moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}

moved {
  from = aws_subnet.net
  to   = module.network.aws_subnet.net
}
