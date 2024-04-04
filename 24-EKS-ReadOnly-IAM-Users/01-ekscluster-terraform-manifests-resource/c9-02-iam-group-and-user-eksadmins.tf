# Resource AWS IAM Group
resource "aws_iam_group" "eksadmins_iam_group" {
  name = "${local.name}-eksadmins"
  path = "/"
}

# Resource AWS IAM Group Policy
resource "aws_iam_group_policy" "eksadmins_iam_group_assumerole_policy" {
  name  = "${local.name}-eksadmins-group-policy"
  group = aws_iam_group.eksadmins_iam_group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = "AllowAssumeOrganizationAccountRole"
        Resource = "${aws_iam_role.eks_admin_role.arn}"
      },
    ]
  })
}

# Resource: AWS IAM User - Basic User 3
resource "aws_iam_user" "eksadmin3_user" {
  name          = "${local.name}-eksadmin3"
  path          = "/"
  force_destroy = true
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-eksadmin3"
    }
  )
}

# Resource: AWS IAM User - Basic User 4
resource "aws_iam_user" "eksadmin4_user" {
  name          = "${local.name}-eksadmin4"
  path          = "/"
  force_destroy = true
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-eksadmin4"
    }
  )
}

# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "eksadmins" {
  name = "${local.name}-eksadmins-group-membership"

  users = [
    aws_iam_user.eksadmin3_user.name,
    aws_iam_user.eksadmin4_user.name,
  ]

  group = aws_iam_group.eksadmins_iam_group.name
}

