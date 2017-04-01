##Pre defined variables
variable "key_path" {}
variable "aws_key_name" {}
variable "aws_region" {}
variable "node_sg_id" {}
variable server_names { type="map" }
variable scripts_file_name { type="map" }
variable scripts_file_path {}
variable os {}
variable tf_home {}
variable user_password { type="map" }
variable hostnames { type="map" }
variable username { type="map" }
variable instance_type { type="map" }


##Module to create repo instances
module "nodejs"{
    source = "./nodejs"
    aws_region = "${var.aws_region}"
    instance_type = "${var.instance_type}"
    aws_key_name = "${var.aws_key_name}"
    node_sg_id ="${var.node_sg_id}"
    server_names ="${var.server_names}"
    scripts_file_path = "${var.scripts_file_path}"
    scripts_file_name = "${var.scripts_file_name}"
    key_path = "${var.key_path}"
    user_password = "${var.user_password}"
    hostnames = "${var.hostnames}"
    username = "${var.username}"
    os = "${var.os}"
    tf_home = "${var.tf_home}"
    instance_type = "${var.instance_type}"
}


output "nodejs_public_ip"{
	value="${module.nodejs.nodejs_public_ip}"

}

