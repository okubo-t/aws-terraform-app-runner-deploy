locals {

  ## app runner role
  apprun-01-role = {
    name = "${var.service_name}-role"

    ## policy-01: AWSAppRunnerServicePolicyForECRAccess

  }

  ## codebuild role
  cb-01-role = {
    name = "${var.service_name}-cb-role"

    policy-01 = {
      name = "${var.service_name}-cb-policy"
    }
    ## policy-02: AmazonEC2ContainerRegistryPowerUser

  }

  ## codepipeline role
  cp-01-role = {
    name = "${var.service_name}-cp-role"

    policy-01 = {
      name = "${var.service_name}-cp-policy"
    }
  }

  ## cloudwatch events role
  cwe-01-role = {
    name = "${var.service_name}-cwe-role"

    policy-01 = {
      name = "${var.service_name}-cwe-policy"
    }

  }

}

## apprunner role
resource "aws_iam_role" "apprun-01-role" {
  name               = local.apprun-01-role["name"]
  assume_role_policy = file("./iam-policy/apprunner-trust-policy.json")
}

resource "aws_iam_role_policy_attachment" "apprun-01-role_policy-01_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
  role       = aws_iam_role.apprun-01-role.id
}

## codebuild role
resource "aws_iam_role" "cb-01-role" {
  name               = local.cb-01-role["name"]
  assume_role_policy = file("./iam-policy/codebuild-trust-policy.json")
}

resource "aws_iam_policy" "cb-01-role_policy-01" {
  name   = local.cb-01-role.policy-01["name"]
  policy = file("./iam-policy/codebuild-policy.json")
}

resource "aws_iam_role_policy_attachment" "cb-01-role_policy-01_attach" {
  policy_arn = aws_iam_policy.cb-01-role_policy-01.arn
  role       = aws_iam_role.cb-01-role.id
}

resource "aws_iam_role_policy_attachment" "cb-01-role_policy-02_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  role       = aws_iam_role.cb-01-role.id
}

## codepipeline role
resource "aws_iam_role" "cp-01-role" {
  name               = local.cp-01-role["name"]
  assume_role_policy = file("./iam-policy/codepipeline-trust-policy.json")
}

resource "aws_iam_policy" "cp-01-role_policy-01" {
  name   = local.cp-01-role.policy-01["name"]
  policy = file("./iam-policy/codepipeline-policy.json")
}

resource "aws_iam_role_policy_attachment" "cp-01-role_policy-01_attach" {
  policy_arn = aws_iam_policy.cp-01-role_policy-01.arn
  role       = aws_iam_role.cp-01-role.id
}

## cloudwatch events role
resource "aws_iam_role" "cwe-01-role" {
  name               = local.cwe-01-role["name"]
  assume_role_policy = file("./iam-policy/cloudwatch-event-trust-policy.json")
}

resource "aws_iam_policy" "cwe-01-role_policy-01" {
  name   = local.cwe-01-role.policy-01["name"]
  policy = file("./iam-policy/cloudwatch-event-policy.json")
}

resource "aws_iam_role_policy_attachment" "cwe-01-role_policy-01_attach" {
  policy_arn = aws_iam_policy.cwe-01-role_policy-01.arn
  role       = aws_iam_role.cwe-01-role.id
}
