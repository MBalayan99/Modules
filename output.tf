output "alb_public_urll" {
  description = "Public URL for Application Load Balancer"
  value       = module.alb.alb_public_url
}

output "asg_instance_idss" {
  description = "Instance IDs in the Auto Scaling Group"
  value       = module.asg.instance_ids
}
