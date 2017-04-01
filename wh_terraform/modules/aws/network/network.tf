

##Module to create security group for nexus and nginx machines
module "sg"{
  source = "./sg"
  node_sg_name = "Nodejs security group"

}

##Outputs
output "node_sg_id"{
	value="${module.sg.node_sg_id}"

}

