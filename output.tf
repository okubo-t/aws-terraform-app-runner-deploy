output "codecommit_repository" {
  value = aws_codecommit_repository.repo-01.clone_url_http
}

output "ecr_repository" {
  value = aws_ecr_repository.ecr-01.repository_url
}
