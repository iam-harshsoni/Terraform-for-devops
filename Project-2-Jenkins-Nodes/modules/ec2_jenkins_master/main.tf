provider "aws" {
  region = "ap-south-1"
}

variable "keypair" {
  description = "keypair"
}

resource "aws_security_group" "sg-jenkins-master" {
  
  name = "web"
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
    to_port = 8080
    from_port = 8080
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
        Name = "sg-jenkins-master"
    }  

}

resource "aws_instance" "ec2_instance" {

    ami = "ami-0dee22c13ea7a9a67"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg-jenkins-master.id]
    key_name = var.keypair

    tags = {
        Name = "Jenkins-Master"
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
                sudo apt update
                sudo apt install fontconfig openjdk-17-jre -y
                sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
                echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update
                sudo apt-get install jenkins -y
                sudo systemctl enable jenkins
                sudo systemctl restart jenkins
            EOF
        ]
    }  
}

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
