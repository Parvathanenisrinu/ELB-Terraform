# Declare variables
variable "env" { }
variable "instance_type" {
  type="map"
  default = {
  dev = "t2.micro"
  prod = "t2.small"
  }
}
variable "vpc_id" { }
variable "ec2_name" { }
variable "ec2_count" {   default = "1" }
variable "ami_id" {}
variable "subnet_id" { default = "subnet-1cd4a422" }
