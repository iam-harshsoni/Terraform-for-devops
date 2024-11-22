# Created Load Balancer Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.lb_arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }
}