# Resource K8s Dev Namespace
resource "kubernetes_namespace_v1" "k8s_dev" {
    metadata {
      name = "dev"
    }
}
