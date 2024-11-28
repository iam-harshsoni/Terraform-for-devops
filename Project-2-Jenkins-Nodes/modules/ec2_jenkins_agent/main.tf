
variable "keypair" {
  description = "keypair"
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_security_group" "sg-jenkins-agent" {
  
  name = "web-jenkins-agent"
  vpc_id = "vpc-04f826a95642cddce"

  ingress {
    description = "HTTP"
    to_port = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    to_port = 443
    from_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom TCP"
    to_port = 8000
    from_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
        Name = "sg-jenkins-agent"
    }  

}

resource "aws_instance" "ec2_instance" {

    ami = "ami-0dee22c13ea7a9a67"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg-jenkins-agent.id]
    key_name = var.keypair

    tags = {
        Name = "Jenkins-Agent"
    }  

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/id_rsa")
        host = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            <<-EOF
                sudo apt-get update
                sudo apt install fontconfig openjdk-17-jre -y
                sudo apt install docker.io -y
                sudo usermod -aG docker $USER && newgrp docker
                sudo apt install docker-compose-v2 -y
                sudo apt restart docker
                sudo reboot
            EOF
        ]
    }  
}

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
