locals {

  apprun-01 = {
    service_name = var.service_name
  }

}

resource "aws_apprunner_service" "apprun-01" {

  depends_on = [aws_ecr_repository.ecr-01,
    aws_iam_role.apprun-01-role
  ]
  service_name = local.apprun-01["service_name"]

  source_configuration {
    auto_deployments_enabled = true

    authentication_configuration {
      access_role_arn = aws_iam_role.apprun-01-role.arn
    }

    image_repository {
      image_identifier      = "${aws_ecr_repository.ecr-01.repository_url}:latest"
      image_repository_type = "ECR"

      image_configuration {
        port = "80"
      }
    }
  }
}
