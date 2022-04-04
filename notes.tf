# --- notes.tf ---

module "iam" {
  source = "./modules/iam/"

  project_tag = "notes"
  repo_tag    = "github.com/maker2413/Notes"
  username    = "notes-service-account"
}

resource "aws_iam_access_key" "notes_access_key" {
  user = module.iam.user.name
}

resource "aws_iam_user_policy" "notes_s3_policy" {
  name = "notes-service-account-s3-policy"
  user = module.iam.user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ObjectLevel",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::www.ethanp.dev/*"
    }
  ]
}
EOF
}
