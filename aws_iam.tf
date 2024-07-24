resource "aws_iam_instance_profile" "role_acesso_ssm" {
  name        = "role-acesso-ssm"
  name_prefix = null
  path        = "/"
  role        = aws_iam_role.role_acesso_ssm.name
  tags        = {}
  tags_all    = {}
}

resource "aws_iam_role" "role_acesso_ssm" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = "Allows EC2 instances to call AWS services on your behalf."
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/AmazonECS_FullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
  max_session_duration  = 3600
  name                  = "role-acesso-ssm"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
  inline_policy {
    name = "policy-get-secret-rds-bia"
    policy = jsonencode({
      Statement = [{
        Action   = ["secretsmanager:GetSecretValue"]
        Effect   = "Allow"
        Resource = ["arn:aws:secretsmanager:us-east-1:590183808614:secret:rds!db-4679cba6-8fbc-4b71-9a4a-219754ab13fb-XWUYah"]
      }]
      Version = "2012-10-17"
    })
  }
}

resource "aws_iam_role_policy_attachment" "role_acesso_ssm_policy" {
  role       = aws_iam_role.role_acesso_ssm.name
  policy_arn = aws_iam_policy.get_secret_bia_db.arn
}