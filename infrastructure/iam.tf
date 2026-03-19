resource "aws_iam_role" "github_actions" {
  name = "GitHubActionsDeployRole"

assume_role_policy = jsonencode({
	Version = "2012-10-17"
	Statement = [
		{
			Effect = "Allow"
			Principal = {
				Federated = "arn:aws:iam::730335220660:oidc-provider/token.actions.githubusercontent.com"
			}
			Action = "sts:AssumeRoleWithWebIdentity"
			Condition = {
				StringEquals = {
					"token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
				}
				StringLike = {
					"token.actions.githubusercontent.com:sub" = [
						"repo:truittjanney/truittjanney.com:ref:refs/heads/main",
						"repo:truittjanney/truittjanney.com:ref:refs/heads/dev"
					]
				}
			}
		}
	]
})
}

resource "aws_iam_role_policy" "github_actions_policy" {
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = [
          "arn:aws:s3:::truittjanney-website-dev",
          "arn:aws:s3:::truittjanney-website-prod"
        ]
      },
      {
        Effect = "Allow"
        Action = ["s3:PutObject", "s3:DeleteObject"]
        Resource = [
          "arn:aws:s3:::truittjanney-website-dev/*",
          "arn:aws:s3:::truittjanney-website-prod/*"
        ]
      },
      {
        Effect = "Allow"
        Action = ["cloudfront:CreateInvalidation"]
        Resource = "*"
      }
    ]
  })
}
