# Resource: Kubernetes Job
resource "kubernetes_job_v1" "irsa_demo" {
  metadata {
    name = "irsa-demo"
  }
  spec {
    template {
      metadata {
        labels = {
          app = "irsa-demo"
        }
      }
      spec {
        service_account_name = kubernetes_service_account_v1.irsa_demo_sa.metadata.0.name 
        container {
          name    = "irsa-demo"
          image   = "amazon/aws-cli:latest"
          command = ["/bin/sh", "-c"]
          # args = ["aws s3 ls"]
          args = ["aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Instance:InstanceId,Subnet:SubnetId}' --output table"]
          #args = ["s3", "ls"]
          #args = ["ec2", "describe-instances"] # Should fail as we don't have access to EC2 Describe Instances for IAM Role
        }
        restart_policy = "Never"
      }
    }
  }
}