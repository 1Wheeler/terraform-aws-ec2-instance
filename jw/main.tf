terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.35.0"
    }
  }
}
 
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
 
}
 
locals {
    amis = {
      ubuntu = {
        us-east-1 = "ami-09e67e426f25ce0d7"
        us-east-2 = "ami-0443305dabd4be2bc"
        us-west-1 = "ami-0feee8eacb52383cc"
    }
  }
}

variable "access_key" {
  type        = string
}
 
variable "secret_key" {
  type        = string
}
 
variable "region" {
  type = string
  default = "us-west-1"
}

variable "morpheususer" {
  type = string
  default = "<%=morpheus.morpheusUser%>"
}
 
resource "aws_instance" "morph_tf_ec2"{
  ami           = local.amis.ubuntu.us-west-1
  instance_type = "t3.micro"
  associate_public_ip_address = true
  key_name= "jwheeler"
  user_data = <<-EOF
   #!/bin/bash
   <%=instance.cloudConfig.agentInstall%>
   EOF
    
  tags = {
      Name = "morph_tf_ec2"
      morph_user = var.morpheususer
  }
}
