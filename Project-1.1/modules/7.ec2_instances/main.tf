# Create an Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = var.iam_role
}

resource "aws_instance" "server1" {

    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet1_id
    security_groups = [var.security_group]

    # Attached IAM Role
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

    user_data = base64encode(file("${path.module}/userdata.sh"))
    tags = {
      Name = var.instance_1_name
    }  
}

resource "aws_instance" "server2" {

    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet2_id
    security_groups = [var.security_group]

    # Attached IAM Role
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

    user_data = base64encode(file("${path.module}/userdata2.sh"))
    tags = {
      Name = var.instance_2_name
    }  
}