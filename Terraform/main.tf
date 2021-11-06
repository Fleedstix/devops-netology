provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}

locals {
  web_instance_type_map = {
    stage = "t3.micro"
    prod = "t3.large"
  }
}

locals {
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
}

locals {
  instances = {
    "t3.micro" = data.aws_ami.ubuntu.id   
    "t3.large" = data.aws_ami.ubuntu.id
  }
}

data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

output "test" {
  value = data.aws_ami.ubuntu
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web_instance_type_map[terraform.workspace]
  count = local.web_instance_count_map[terraform.workspace]
  tags = {
    Name = "var.role.var.project-var.environment"
    Environment = "var.environment"
    Project = "var.project"
    Role = "var.role"
    ForgeBucket = "telusdigital-forge"
    ForgeRegion = "eu-central-1"
    AmazonInspectorScan = "yes"
  }

  lifecycle {
    create_before_destroy = true   
    prevent_destroy = true
    ignore_changes = ["tags"] 
  }

}

resource "aws_instance" "db" {
  ami = each.value
  for_each = local.instances
  instance_type = each.key
  tags = {
    Name = "var.role}.var.project}-var.environment"
    Environment = "var.environment"
    Project = "var.project"
    Role = "var.role"
    ForgeBucket = "telusdigital-forge"
    ForgeRegion = "eu-central-1"
    AmazonInspectorScan = "yes"
  }

}

data "aws_caller_identity" "current" {}

data "aws_regions" "current" {}
