#################################
##			Variables		   ##
#################################
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-west-1"
}
variable "vpc_name" {
  type        = "string"
  description = "Enter a Name for the VPC."
}
variable "vpc_description" {
  description = "Enter a friendly description for this VPC"
}
variable "cidr_block" {
  description = "Enter your CIDR block for the VPC.  Example: 10.150.0.0/16"
  default = "10.0.0.0/16"
}