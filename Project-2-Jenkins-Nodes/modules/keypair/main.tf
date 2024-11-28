resource "aws_key_pair" "example" {
  key_name = "terraform-jenkins-agent"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "keypair" {
  value = aws_key_pair.example.key_name
}