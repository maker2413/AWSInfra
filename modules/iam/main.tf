# --- iam/main.tf ---

resource "aws_iam_user" "user" {
  name = var.username

  tags = merge(
    {
      Environment = terraform.workspace
      Module      = "iam"
    },
    var.tags,
  )
}
