# ---------------------------------------------------------------------------------------------------------------------
# Application Load Balancer
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_lb" "alb" {
  name                              = substr(var.name, 0, 32)
  internal                          = var.internal
  load_balancer_type                = "application"
  enable_deletion_protection        = var.enable_deletion_protection
  enable_cross_zone_load_balancing  = var.enable_cross_zone_load_balancing
  ip_address_type                   = var.ip_address_type
  security_groups                   = (length(var.security_group_ids) == 0) ? [aws_security_group.alb[0].id] : var.security_group_ids

  dynamic "subnet_mapping"{
    for_each = var.subnet_ids
    content {
      subnet_id             = subnet_mapping.value
    }
  }
  access_logs {
    enabled = var.access_logs.enabled
    bucket  = var.access_logs.bucket
    prefix  = var.access_logs.prefix
  }
  tags        = var.tags
}

resource "aws_security_group" "alb" {
  count             = (length(var.security_group_ids) == 0) ? 1 : 0

  name              = var.name
  description       = "Load Balancer default security group"
  vpc_id            = var.vpc_id
  tags              = var.tags
}
# Needed this locals for security_group_id, because had trouble outputing value of "security_groups" straight from the ALB
locals {
  security_group_id = (length(var.security_group_ids) == 0) ? aws_security_group.alb[0].id : var.security_group_ids[0]
}