#data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn
#data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn
# https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html

# Resource: Create IAM Role and associate the EBS IAM Policy to it
resource "aws_iam_role" "irsa_iam_role" {
  name = "${local.name}-irsa-iam-role"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {            
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:default:irsa-demo-sa"
          }
        }        

      },
    ]
  })

  tags = merge(
    local.common_tags,
      {
        tag-key = "${local.name}-irsa-iam-role"
      }
      )
}

# Associate IAM Role and Policy For S3 Bucket
resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach_s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.irsa_iam_role.name
}

# Associate IAM Role and Policy For EC2 Access
resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.irsa_iam_role.name
}

output "irsa_iam_role_arn" {
  description = "IRSA Demo IAM Role ARN"
  value = aws_iam_role.irsa_iam_role.arn
}


