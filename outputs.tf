#outputs.tf

output "public_ip" {
  value = aws_instance.web.public_ip
}
output "url" {
  value = "http://${aws_instance.web.public_ip}"
}
/*output "subnet_ids" {
  value = { for k, s in module.network.aws_subnet.net : k=> s.id }
}*/
output "vpc_id" {
  value = module.network.vpc_id
}
output "subnet_net" {
  value = module.network.subnet_ids
}
