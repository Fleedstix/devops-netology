output "instance_public_ip" {
  value = "${aws_instance.default.public_ip}"
}

output "instance_id" {
  value = "${aws_instance.default.id}"
}

output "instance_private_ip" {
  value = "${aws_instance.default.private_ip}"
}

output "instance_public_dns" {
  value = "${aws_instance.default.public_dns}"
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = data.aws_regions.current.names
}