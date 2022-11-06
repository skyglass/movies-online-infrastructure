# Resource: Keycloak Service
resource "kubernetes_service_v1" "keycloak_service" {
  depends_on = [var.sample_app_depends_on]  
  metadata {
    name = "keycloak"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.keycloak_deployment.spec.0.selector.0.match_labels.app 
    }
    port {
      protocol = "TCP"
      name = "keycloak"
      port = 80 # Service Port
      target_port = 8080
    }
  }
}