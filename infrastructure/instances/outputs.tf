output "alb_dns_name" {
  description = "The LB DNS name"
  value       = aws_lb.ecs_alb.dns_name
}

output "target_group_arn" {
  description = "The target group ARN"
  value       = aws_lb_target_group.ecs_tg.arn
}
