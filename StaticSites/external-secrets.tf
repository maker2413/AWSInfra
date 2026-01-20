# --- StaticSites/external-secrets.tf ---

data "aws_caller_identity" "current" {}

resource "aws_iam_user" "external_secrets" {
  name = "external-secrets"
}

resource "aws_iam_user_policy" "ssm_read" {
  name = "external-secrets-ssm-read"
  user = aws_iam_user.external_secrets.name
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = concat(
      [
        {
          Sid      = "ReadParameters"
          Effect   = "Allow"
          Action   = [
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetParametersByPath"
          ]
          Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/*"
        }
      ],
      [
        {
          Sid      = "DecryptSecureString"
          Effect   = "Allow"
          Action   = ["kms:Decrypt"]
          # Using * with a condition restricts decrypt usage only when invoked via SSM in this region
          Resource = "*"
          Condition = {
            StringEquals = {
              "kms:ViaService" = "ssm.${var.aws_region}.amazonaws.com"
            }
          }
        }
      ]
    )
  })
}

# Access key for k3s cluster (Terraform state will store the secret!)
resource "aws_iam_access_key" "external_secrets" {
  user = aws_iam_user.external_secrets.name
}
