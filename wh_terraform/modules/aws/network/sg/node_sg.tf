##Pre defined variables

variable node_sg_name {}

##Nexus security group
resource "aws_security_group" "node" {
    name = "${var.node_sg_name}"
    description = "Allow incoming nodejs connections."

    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
	

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    
    tags {
        Name = "${var.node_sg_name}"
	"Application Role" = "Node security group"
        "Opt out" = "true"
        "Project" = "WH"
    }
}

##Output
output "node_sg_id"{
	value="${aws_security_group.node.id}"
}