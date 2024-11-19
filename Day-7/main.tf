provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address = "http://3.110.217.237:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "7215d210-175a-cefc-b324-f697b174848f"
      secret_id = "f0150c8d-25cb-b716-a51a-5fbde6fc3b8d"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "test-secret"
}

resource "aws_instance" "example" {
  ami = "ami-0dee22c13ea7a9a67"
  instance_type = "t2.micro"

  tags = {
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }

}