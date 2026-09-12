#variables.tf

variable "project" {
  type    = string
  default = "tf-shop"
}
variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}
variable "tags" {
type =  map(string)
}
variable "subnets" {
  type = map(object({ netnum = number, az = string }))
  default = {
    public-a  = { netnum = 1, az = "a" }
    private-b = { netnum = 11, az = "b" }
    private-c = { netnum = 12, az = "c" }
    }
  }

