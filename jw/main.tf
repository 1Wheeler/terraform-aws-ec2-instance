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
    }
  }
  cloud-settings = {
    hostname = "<%=instance.name%>"
    api_key = "<%=instance.container.apiKey%>"
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
  default = "us-east-1"
}

variable "newagentinstall" {
  type = string
  default = "<%=cloudConfig.agentInstall%>"
}

variable "linuxUsername" {
  type = string
  default = "<%=username%>"
}
variable "morpheususer" {
  type = string
  default = "<%=morpheus.morpheusUser%>"
}
 
resource "aws_instance" "morph_tf_ec2"{
  ami           = local.amis.ubuntu.us-east-1
  instance_type = "t3.micro"
  associate_public_ip_address = true
  user_data = <<-EOF
   #!/bin/bash
   var.newagentinstall
   EOF
    
  tags = {
      Name = "morph_tf_ec2"
      linux_user = var.linuxUsername
      morph_user = var.morpheususer
      api_key = local.cloud-settings.api_key
  }
}
