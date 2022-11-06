# Resource: Movies UI Service
resource "kubernetes_service_v1" "movies_ui_service" {
  depends_on = [kubernetes_service_v1.movies_api_service]
  metadata {
    name = "movies-ui"
    annotations = {
      "alb.ingress.kubernetes.io/healthcheck-path" = "/index.html"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.movies_ui_deployment.spec.0.selector.0.match_labels.app 
    }
    port {
      name = "http"
      port = 80 # Service Port
      target_port = 80
    }

    type = "NodePort"
  }
}