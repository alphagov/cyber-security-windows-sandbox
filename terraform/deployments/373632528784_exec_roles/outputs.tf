output "wec_exec_role_arn" {
  description = "The ARN of the WEC instance profile role"
  value       = module.exec_roles.wec_exec_role_arn
}
