variable "rt-name" {
  description = "route table name"
}

variable "vpc_id" {
  description = "this vpc id is needed for routetable"
}

variable "igw_id" {
  description = "this igw id is needed for routetable"
}

variable "subnet1_id" {
  description = "this is subnet1 id for routetable association"
}

variable "subnet2_id" {
  description = "this is subnet2 id for routetable association"
}