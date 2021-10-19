provider "aws" {
	region     = var.awsRegion
	access_key = var.key_id
	secret_key = var.key_psw
}

resource "aws_iam_user" "lb" {
	name = var.userName
}

resource "aws_instance" "Example" {
	ami = "ami-048050c2a8eb8d6e2"
	instance_type = "t2.micro"
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attachment" {
  user       = var.userName
  policy_arn = aws_iam_policy.policy.arn
}