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

variable "instancename" {
  type = string
  default = "<%=instance.name%>"
}
 
resource "aws_instance" "jwec2ubuntu" {
  ami           = local.amis.ubuntu.us-west-1
  name = var.instancename
  instance_type = "t3.micro"
  associate_public_ip_address = true
  key_name= "jwheeler"
  subnet_id = "<%customOptions.networksapiexternal%>"
  user_data = <<-EOF
   #cloud-config
   runcmd:
   - <%=instance.cloudConfig.agentInstall%>
   EOF
    
  tags = {
      Name = var.instancename
  }
}
