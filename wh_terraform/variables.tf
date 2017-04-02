##Variables for terraform

##Run time variable
variable "tf_home" {
    description = "Path where main.tf is present"
    default = "/home/janedoe/wh_nodejs_app/wh_terraform"  ##Add the path here or pass it while executing terraform apply
} 

#AWS Key name
variable "aws_key_name" {
	description = "Name of the key in AWS"
	default = "wh_nodejs_key"
}

variable "key_path" {
	description = "path where keypair is stored"
	default = "setup/dta"

}

##AWS default region 
variable "aws_region" {
    description = "Region"
    default = "us-east-1"
}


##Define variables
variable "instance_type" {
    description = "Instance type"
    type = "map"
    default = {
  	nodejs="t2.medium"
 }
}


##Names of machines to appear on AWS console
variable "server_names" {
    description = "Names for machines"
    type="map"
    default = {
	nodejs="ak-wh-nodejs"
 }
}

##Username for user to be added.
variable "username" {
    description = "Users for machines"
    type="map"
    default = {
	nodejs="whuser"
 }
}


##Password for user to be added. Current default user compose.
##Please add the passwords for each machine. Keep password 10 character long. Do not use special characters like '$','\\',':','"','''
variable "user_password" {
    description = "Passwords for machines"
    type="map"
    default = {
	nodejs="Place your password here",
	   	
 }
}

##Hostnames for servers
variable "hostnames" {
    description = "Hostnames for machines"
    type="map"
    default = {
	nodejs="wh-nodejs.whitehedge.local",
	   	
 }
}

##Path for the scripts to be run after instances are provisioned
variable "scripts_file_path" {
	default = "scripts"
}

##Target OS for the instances
variable "os" {
	default = "Ubuntu16"
}


##file path for scripts
variable "scripts_file_name" {
    description = "Path to script file"
    type="map"
    default = {
	configure="server_config.sh",
 	add_hosts="add_hosts.sh",
	passwordless="passwordless.expect"
   }
}
