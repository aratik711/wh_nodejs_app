##Pre defined variables
variable aws_key_name {}
variable key_path {}
variable node_sg_id {}
variable server_names { type="map" }
variable scripts_file_name { type="map" }
variable scripts_file_path {}
variable os {}
variable hostnames {type="map"}
variable user_password {type="map"}
variable username { type="map" }
variable tf_home {}
variable instance_type { type="map" }
variable aws_region {}

##retrieve the AMI id of the Ubuntu template
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


##Create Nodejs instance
resource "aws_instance" "nodejs" {
    ami = "${data.aws_ami.ubuntu.id}" 
    instance_type = "${lookup(var.instance_type, "nodejs")}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${var.node_sg_id}"]
    associate_public_ip_address = true
    source_dest_check = false
    disable_api_termination = true
    tags {
        Name = "${var.server_names["nodejs"]}"
	"Application Role" = "Nodejs/nginx"
        "Opt out" = "true"
        "Project" = "WH"
    }

     provisioner "file" {
        source = "${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["configure"]}"
        destination = "/tmp/${var.scripts_file_name["configure"]}"        
	connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("${var.tf_home}/${var.key_path}/${var.aws_key_name}.pem")}"
        timeout = "4m"
        agent = false
        }
    }
   
    provisioner "remote-exec" {
        inline = [
          "chmod +x /tmp/${var.scripts_file_name["configure"]}",
          "sh /tmp/${var.scripts_file_name["configure"]} ${var.username["nodejs"]} '${var.user_password["nodejs"]}' ${var.hostnames["nodejs"]}",
	  "sudo cp /usr/bin/python3.5 /usr/bin/python"
	 
        ]

        connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("${var.tf_home}/${var.key_path}/${var.aws_key_name}.pem")}"
        timeout = "4m"
        agent = false
        }

   }

   provisioner "local-exec" {
	command = "sudo yum install -y expect && chmod +x ${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["add_hosts"]} && sh ${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["add_hosts"]} ${aws_instance.nodejs.public_ip} ${var.hostnames["nodejs"]} && 	chmod +x ${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["passwordless"]} && ${var.tf_home}/${var.scripts_file_path}/${var.os}/${var.scripts_file_name["passwordless"]} ${var.user_password["nodejs"]} ${var.username["nodejs"]}@${var.hostnames["nodejs"]}"
}
 


}


##Output
output "nodejs_public_ip" {
	value = "${aws_instance.nodejs.public_ip}"
}

