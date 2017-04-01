
##Configuring AWS default credentials
module "providers" {
  source = "./providers/aws/dta"
}


##Add region to the provider
provider "aws" {
	region = "${var.aws_region}"
}

##Add keypair to the AWS location
module "keypair" {
	source = "./modules/aws/keypair"
	key_path = "${var.key_path}"
	aws_key_name = "${var.aws_key_name}"

}

##Create network for the infrastructure
module "network" {
  source = "./modules/aws/network"
}


##Create instances for the infrastructure
module "compute" {
  source = "./modules/aws/compute"
  aws_region = "${var.aws_region}"
  key_path = "${var.key_path}"
  aws_key_name = "${var.aws_key_name}"
  server_names = "${var.server_names}"
  scripts_file_path = "${var.scripts_file_path}"
  scripts_file_name = "${var.scripts_file_name}"
  user_password = "${var.user_password}"
  hostnames = "${var.hostnames}"
  username ="${var.username}"
  os = "${var.os}"
  tf_home = "${var.tf_home}"
  instance_type = "${var.instance_type}"
  node_sg_id = "${module.network.node_sg_id}"

    
}


output "01_Information" {
	value="You can now login to ${var.hostnames["nodejs"]}/${module.compute.nodejs_public_ip} with user ${var.username["nodejs"]} and password ${var.user_password["nodejs"]}. You can login with hostname without any password from terraform server. Else you can use Public IP and password"

}

