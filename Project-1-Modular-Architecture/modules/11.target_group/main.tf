# Creating Target Group
resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# Attaching Target Group to Load Balancer
resource "aws_lb_target_group_attachment" "attach_all_instance" {
   for_each       = {
    server1 = var.instance1_id,
    server2 = var.instance2_id
  }
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = each.value
  port             = 80
}