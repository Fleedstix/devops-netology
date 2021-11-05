provider "aws" {
  region     = "us-west-2"
  access_key = "AKIATII3CDRVD7QMZFHL"
  secret_key = "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"
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
  instance_type = "t3.micro"

  tags = {
    Name = "${var.role}.${var.project}-${var.environment}"
    Environment = "${var.environment}"
    Project = "${var.project}"
    Role = "${var.role}"
    ForgeBucket = "telusdigital-forge"
    ForgeRegion = "eu-central-1"
    AmazonInspectorScan = "yes"
  }

  root_block_device = {
    volume_type = "${var.instance_root_volume_type}"
    volume_size = "${var.instance_root_volume_size}"
    iops = "${var.instance_root_volume_provisioned_io}"
    delete_on_termination = "${var.instance_root_volume_delete_on_termination}"
  }

}

data "aws_caller_identity" "current" {}

data "aws_regions" "current" {}
