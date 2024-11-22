// Create Load Balancer
resource "aws_lb" "myalb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type

  security_groups    = [var.security_groups]
  subnets            = [var.subnet1_id,var.subnet2_id,]

  tags = {
    Name = var.lb_name
  }
}
