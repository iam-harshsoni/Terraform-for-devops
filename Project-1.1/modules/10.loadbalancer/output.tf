output "lb_arn" {
  value = aws_lb.myalb.arn
}

output "lb_dns" {
  value = aws_lb.myalb.dns_name
}