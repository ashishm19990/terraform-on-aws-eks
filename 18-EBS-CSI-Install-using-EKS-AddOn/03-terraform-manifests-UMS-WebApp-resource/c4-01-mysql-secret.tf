resource "kubernetes_secret_v1" "mysql_secret" {
  metadata {
    name = "mysql-secret"
  }

  data = {
    password = "dbpassword11"
  }

  type = "kubernetes.io/basic-auth"
}
