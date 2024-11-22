# Create VPC
module "vpc" {
  source = "./modules/1.vpc"

  name = var.vpc_name
  cidr = var.cidr
}

# Create Subnet-1
module "subnet" {
  source = "./modules/2.subnets"
  
  sub1_name=var.sub1_name
  sub1_cidr_block=var.sub1_cidr_block
  sub1_availability_zone=var.sub1_availability_zone

  sub2_name=var.sub2_name
  sub2_cidr_block=var.sub2_cidr_block
  sub2_availability_zone=var.sub2_availability_zone
  vpc_id= module.vpc.vpc_id
}

# Create Internet Gateway
module "igw" {
  source = "./modules/3.igw"
  igw_name = var.igw_name
  vpc_id = module.vpc.vpc_id
}

# Create Route Table
module "route_table" {
  source = "./modules/4.route_table"
  
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
  subnet1_id = module.subnet.sub1_id
  subnet2_id = module.subnet.sub2_id
  rt-name = var.rt-name
}

# Create security Group
module "security_group" {
  source = "./modules/5.security_group"
  vpc_id = module.vpc.vpc_id
  security_group_name=var.security_group_name
}

# Create s3 bucket
module "s3_bucket" {
  source = "./modules/8.s3_bucket"
  s3_bucket_name = var.s3_bucket_name
}

# uploading objects in s3 bucket
module "s3_bucket_object" {
  source = "./modules/9.s3_bucket_object"
  s3_bucket_name = var.s3_bucket_name
  ownership_controls = module.s3_bucket.ownership_controls
  public_aacess_block = module.s3_bucket.public_aacess_block
}

# uploading objects in s3 bucket
module "iam_role" {
  source = "./modules/6.iam_roles"   
}

# Creating ec2_insatnce
module "ec2_insatnces" {
  source = "./modules/7.ec2_instances"
  instance_1_name = var.instance_1_name
  instance_2_name = var.instance_2_name
  ami_id = var.ami_id
  iam_role = module.iam_role.iam_role
  instance_type = var.instance_type
  subnet1_id  = module.subnet.sub1_id
  subnet2_id = module.subnet.sub2_id
  security_group = module.security_group.security_group_id
}

# Creating Load Balancer
module "loadbalancer" {
  source = "./modules/10.loadbalancer"
  lb_name = var.lb_name
  lb_type = var.lb_type
  security_groups = module.security_group.security_group_id
  subnet1_id  = module.subnet.sub1_id
  subnet2_id = module.subnet.sub2_id 
}

# Creating Target Group
module "targetgroup" {
  source = "./modules/11.target_group"
  tg_name = var.tg_name
  vpc_id = module.vpc.vpc_id
  instance1_id = module.ec2_insatnces.ec2_insatnce_1_id
  instance2_id = module.ec2_insatnces.ec2_insatnce_2_id  
}

# Creating LoadBalancer Listener
module "loadbalancer_listener" {
  source = "./modules/12.loadbalancer_listener"
  
  lb_arn = module.loadbalancer.lb_arn
  tg_arn = module.targetgroup.tg_arn
}


output "vpc-id" {
  value = module.vpc.vpc_id
}
output "subnet1-id" {
  value = module.subnet.sub1_id
}
output "subnet2-id" {
  value = module.subnet.sub2_id
}
output "igw-id" {
  value = module.igw.igw_id
}
output "security_group_id" {
  value = module.security_group.security_group_id
}
output "ec2_instance1" {
  value = module.ec2_insatnces.ec2_insatnce_1_id
}
output "ec2_instance2" {
  value = module.ec2_insatnces.ec2_insatnce_2_id
}

output "lb_dns" {
  value = module.loadbalancer.lb_dns
}
