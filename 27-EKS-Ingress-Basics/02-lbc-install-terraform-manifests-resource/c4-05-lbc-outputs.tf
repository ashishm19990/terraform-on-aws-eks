# Helm Release Outputs
output "lbc_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.loadbalancer_controller.metadata
}

# Helm Status of the release Outputs
output "lbc_helm_status" {
  description = "Metadata Block outlining status of the deployed release."
  value       = helm_release.loadbalancer_controller.status
}

