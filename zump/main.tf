resource "local_file" "devops" {
  filename = "/workspaces/Terraform-for-devops/zump/devops.txt"
  content = var.devops_learn[0] 
  }

  output "demo_state" {
    value = var.devops_learn[1]
    sensitive = true
  }