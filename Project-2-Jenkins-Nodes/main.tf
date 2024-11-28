provider "aws" {
  region = "ap-south-1"
}

//create jenkins-Agent
module "keypair" {
  source = "./modules/keypair"
}

//create jenkins-master
module "ec2_instance_jenkins_master" {
  source = "./modules/ec2_jenkins_master"
  keypair = module.keypair.keypair
}

//create jenkins-Agent
module "ec2_instance_jenkins_agent" {
  source = "./modules/ec2_jenkins_agent"
  keypair = module.keypair.keypair
}


output "ec2_public_ip_jenkins_master" {
  value = module.ec2_instance_jenkins_master.ec2_public_ip
}

output "ec2_public_ip_jenkins_agent" {
  value = module.ec2_instance_jenkins_agent.ec2_public_ip
}