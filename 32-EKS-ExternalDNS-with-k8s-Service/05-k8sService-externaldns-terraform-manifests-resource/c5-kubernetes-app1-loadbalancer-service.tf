# Kubernetes Service Manifest (Type: Load Balancer Service)
resource "kubernetes_service_v1" "myapp1_np_service" {
  metadata {
    name = "app1-nginx-loadbalancer-service"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type"             = "external"
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" = "tcp"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/healthcheck-path"                    = "/app1/index.html"
      "service.beta.kubernetes.io/aws-load-balancer-subnets"          = "${join(",", "${data.terraform_remote_state.eks.outputs.public_subnets[*]}")}"
      "external-dns.alpha.kubernetes.io/hostname"                     = "tfextdns-k8s-service-demo101.vardhmangarmants.store"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
