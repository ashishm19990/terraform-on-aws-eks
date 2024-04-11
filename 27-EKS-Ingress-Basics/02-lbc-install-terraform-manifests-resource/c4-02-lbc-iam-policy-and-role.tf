/*
aws iam create-policy \
    --policy-name inboxable-dev-AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

# arn:aws:iam::567344542386:policy/inboxable-dev-AWSLoadBalancerControllerIAMPolicy

oidc_id=$(aws eks describe-cluster --name inboxable-dev-eksdemo1 --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)

aws iam create-role \
  --role-name inboxable-dev-lbc-iam-role \
  --assume-role-policy-document file://"load-balancer-role-trust-policy.json"

aws iam attach-role-policy \
  --policy-arn arn:aws:iam::567344542386:policy/inboxable-dev-AWSLoadBalancerControllerIAMPolicy \
  --role-name inboxable-dev-lbc-iam-role

kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.13.5/cert-manager.yaml

curl -Lo cert-manager.yaml https://github.com/jetstack/cert-manager/releases/download/v1.13.5/cert-manager.yaml

curl -Lo v2_7_1_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.7.1/v2_7_1_full.yaml

eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster inboxable-dev-eksdemo1 \
    --approve

eksctl create iamserviceaccount \
  --cluster=inboxable-dev-eksdemo1 \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name inboxable-dev-lbc-iam-role \
  --attach-policy-arn=arn:aws:iam::567344542386:policy/inboxable-dev-AWSLoadBalancerControllerIAMPolicy \
  --approve

  aws-load-balancer-webhook-service.kube-system, aws-load-balancer-webhook-service.kube-system.svc, aws-load-balancer-webhook-service.kube-system.svc.cluster.local

*/

# Resource: Create AWS Load Balancer Controller IAM Policy 
resource "aws_iam_policy" "lbc_iam_policy" {
  name        = "${local.name}-AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "AWS Load Balancer Controller IAM Policy"
  #policy = data.http.lbc_iam_policy.body
  policy = data.http.lbc_iam_policy.response_body
}

output "lbc_iam_policy_arn" {
  value = aws_iam_policy.lbc_iam_policy.arn
}

# Resource: Create IAM Role 
resource "aws_iam_role" "lbc_iam_role" {
  name = "${local.name}-lbc-iam-role" # 

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
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:aud" : "sts.amazonaws.com",
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      },
    ]
  })

  tags = merge(
    local.common_tags,
    {
      tag-key = "AWSLoadBalancerControllerIAMPolicy"
    }
  )
}

# Associate Load Balanacer Controller IAM Policy to  IAM Role
resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.lbc_iam_policy.arn
  role       = aws_iam_role.lbc_iam_role.name
}

output "lbc_iam_role_arn" {
  description = "AWS Load Balancer Controller IAM Role ARN"
  value       = aws_iam_role.lbc_iam_role.arn
}
