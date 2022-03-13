output "load-balancer" {
  value = aws_lb.alb
}
output "security_group_id" {
  value = local.security_group_id
}