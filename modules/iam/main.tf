# --- iam/main.tf ---

resource "aws_iam_user" "user" {
  name = var.username

  tags = {
    Module  = "iam"
    Project = var.project_tag
    Repo    = var.repo_tag
  }
}
