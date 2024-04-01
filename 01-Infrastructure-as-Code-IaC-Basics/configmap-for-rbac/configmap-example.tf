# Datasource: EBS CSI IAM Policy get from EBS GIT Repo (latest)
data "http" "ebs_csi_iam_policy" {
  url = "https://github.com/kubernetes-sigs/aws-iam-authenticator/blob/master/deploy/example.yaml"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

output "ebs_csi_iam_policy" {
  #value = data.http.ebs_csi_iam_policy.body
  value = data.http.ebs_csi_iam_policy.response_body
}
