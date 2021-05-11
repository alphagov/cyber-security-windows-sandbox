output "wec_exec_role_arn" {
  description = "The ARN of the WEC instance profile role"
  value       = aws_iam_role.wec_exec_role.arn
}
