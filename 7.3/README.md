# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"


> 1. Выполните terraform init
```
C:\Users\pvdil\Desktop\devops-netology\Terraform>terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 3.0"...
- Installing hashicorp/aws v3.64.2...
- Installed hashicorp/aws v3.64.2 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

> 2. Создайте два воркспейса stage и prod.


```
C:\Users\pvdil\Desktop\devops-netology\Terraform>terraform workspace new stage
Created and switched to workspace "stage"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

C:\Users\pvdil\Desktop\devops-netology\Terraform>terraform workspace new prod
Created and switched to workspace "prod"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

```

> 3-7.

[Terraform директория](../Terraform)

> 6. В виде результата работы пришлите:
Вывод команды terraform workspace list

```
C:\Users\pvdil\Desktop\devops-netology\Terraform>terraform workspace list
  default
* prod
  stage
```

> Вывод команды terraform plan для воркспейса prod.

```
Terraform will perform the following actions:

  # aws_instance.db["t3.large"] will be created
  + resource "aws_instance" "db" {
      + ami                                  = "ami-036d46416a34a611c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.large"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role}.var.project}-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tags_all                             = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role}.var.project}-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.db["t3.micro"] will be created
  + resource "aws_instance" "db" {
      + ami                                  = "ami-036d46416a34a611c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role}.var.project}-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tags_all                             = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role}.var.project}-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.web[0] will be created
  + resource "aws_instance" "web" {
      + ami                                  = "ami-036d46416a34a611c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.large"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role.var.project-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tags_all                             = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role.var.project-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.web[1] will be created
  + resource "aws_instance" "web" {
      + ami                                  = "ami-036d46416a34a611c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.large"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role.var.project-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tags_all                             = {
          + "AmazonInspectorScan" = "yes"
          + "Environment"         = "var.environment"
          + "ForgeBucket"         = "telusdigital-forge"
          + "ForgeRegion"         = "eu-central-1"
          + "Name"                = "var.role.var.project-var.environment"
          + "Project"             = "var.project"
          + "Role"                = "var.role"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + account_id          = "223931931754"
  + aws_region          = [
      + "ap-northeast-1",
      + "ap-northeast-2",
      + "ap-northeast-3",
      + "ap-south-1",
      + "ap-southeast-1",
      + "ap-southeast-2",
      + "ca-central-1",
      + "eu-central-1",
      + "eu-north-1",
      + "eu-west-1",
      + "eu-west-2",
      + "eu-west-3",
      + "sa-east-1",
      + "us-east-1",
      + "us-east-2",
      + "us-west-1",
      + "us-west-2",
    ]
  + caller_arn          = "arn:aws:iam::223931931754:root"
  + caller_user         = "223931931754"
  + instance_id         = "aws_instance.default.id"
  + instance_private_ip = "aws_instance.default.private_ip"
  + instance_public_dns = "aws_instance.default.public_dns"
  + instance_public_ip  = "aws_instance.default.public_ip"
  + test                = {
      + architecture          = "x86_64"
      + arn                   = "arn:aws:ec2:us-west-2::image/ami-036d46416a34a611c"
      + block_device_mappings = [
          + {
              + device_name  = "/dev/sda1"
              + ebs          = {
                  + "delete_on_termination" = "true"
                  + "encrypted"             = "false"
                  + "iops"                  = "0"
                  + "snapshot_id"           = "snap-025b2351293c6df25"
                  + "throughput"            = "0"
                  + "volume_size"           = "8"
                  + "volume_type"           = "gp2"
                }
              + no_device    = ""
              + virtual_name = ""
            },
          + {
              + device_name  = "/dev/sdb"
              + ebs          = {}
              + no_device    = ""
              + virtual_name = "ephemeral0"
            },
          + {
              + device_name  = "/dev/sdc"
              + ebs          = {}
              + no_device    = ""
              + virtual_name = "ephemeral1"
            },
        ]
      + creation_date         = "2021-10-22T00:40:58.000Z"
      + description           = "Canonical, Ubuntu, 20.04 LTS, amd64 focal image build on 2021-10-21"
      + ena_support           = true
      + executable_users      = null
      + filter                = [
          + {
              + name   = "name"
              + values = [
                  + "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*",
                ]
            },
          + {
              + name   = "virtualization-type"
              + values = [
                  + "hvm",
                ]
            },
        ]
      + hypervisor            = "xen"
      + id                    = "ami-036d46416a34a611c"
      + image_id              = "ami-036d46416a34a611c"
      + image_location        = "099720109477/ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211021"
      + image_owner_alias     = null
      + image_type            = "machine"
      + kernel_id             = null
      + most_recent           = true
      + name                  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211021"
      + name_regex            = null
      + owner_id              = "099720109477"
      + owners                = [
          + "099720109477",
        ]
      + platform              = null
      + platform_details      = "Linux/UNIX"
      + product_codes         = []
      + public                = true
      + ramdisk_id            = null
      + root_device_name      = "/dev/sda1"
      + root_device_type      = "ebs"
      + root_snapshot_id      = "snap-025b2351293c6df25"
      + sriov_net_support     = "simple"
      + state                 = "available"
      + state_reason          = {
          + "code"    = "UNSET"
          + "message" = "UNSET"
        }
      + tags                  = {}
      + usage_operation       = "RunInstances"
      + virtualization_type   = "hvm"
    }

```