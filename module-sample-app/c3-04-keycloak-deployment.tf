# Resource: Mongo DB Kubernetes Deployment
resource "kubernetes_deployment_v1" "keycloak_deployment" {
  depends_on = [var.sample_app_depends_on]  
  metadata {
    name = "keycloak"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "keycloak"
      }          
    }
    template {
      metadata {
        labels = {
          app = "keycloak"
        }
      }
      spec {
        volume {
          name = "keycloak-persistent-storage"
          persistent_volume_claim {
            #claim_name = kubernetes_persistent_volume_claim_v1.keycloak_pvc.metadata.0.name # THIS IS NOT GOING WORK, WE NEED TO GIVE PVC NAME DIRECTLY OR VIA VARIABLE, direct resource name reference will fail.
            claim_name = "ebs-keycloak-pv-claim"
          }
        }
        container {
          name = "keycloak"
          image = "quay.io/keycloak/keycloak:18.0.2"
          image_pull_policy = "Always"
          args = ["start-dev"]
          port {
            container_port = 8080
            host_port = 8080
          }
          env {
            name = "KEYCLOAK_ADMIN"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "KEYCLOAK_ADMIN"
              }
            }
          } 
          env {
            name = "KEYCLOAK_ADMIN_PASSWORD"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "KEYCLOAK_ADMIN_PASSWORD"
              }
            }
          }                     
          env {
            name = "KEYCLOAK_USER"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "KEYCLOAK_USER"
              }
            }
          }
          env {
            name = "KEYCLOAK_MGMT_USER"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "KEYCLOAK_MGMT_USER"
              }
            }
          }
          env {
            name = "JAVA_OPTS_APPEND"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "JAVA_OPTS_APPEND"
              }
            }
          }
          env {
            name = "DB_VENDOR"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "DB_VENDOR"
              }
            }
          }
         
          env {
            name = "KEYCLOAK_LOGLEVEL"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "KEYCLOAK_LOGLEVEL"
              }
            }
          }
          env {
            name = "ROOT_LOGLEVEL"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map_v1.keycloak_config_map.metadata.0.name
                key = "ROOT_LOGLEVEL"
              }
            }
          }
          env {
            name = "KEYCLOAK_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KEYCLOAK_PASSWORD"
              }
            }
          }
          env {
            name = "KEYCLOAK_MGMT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KEYCLOAK_MGMT_PASSWORD"
              }
            }
          }                  

          env {
            name = "KC_HTTP_ENABLED"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_HTTP_ENABLED"
              }
            }
          }

          env {
            name = "KC_HOSTNAME"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_HOSTNAME"
              }
            }
          }

          env {
            name = "KC_HOSTNAME_PORT"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_HOSTNAME_PORT"
              }
            }
          }

          env {
            name = "KC_HOSTNAME_STRICT_BACKCHANNEL"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_HOSTNAME_STRICT_BACKCHANNEL"
              }
            }
          }

          env {
            name = "KC_HOSTNAME_STRICT_HTTPS"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_HOSTNAME_STRICT_HTTPS"
              }
            }
          }

          env {
            name = "KC_PROXY"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_PROXY"
              }
            }
          }

          env {
            name = "KC_PROXY_ADDRESS_FORWARDING"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "KC_PROXY_ADDRESS_FORWARDING"
              }
            }
          }

          env {
            name = "PROXY_ADDRESS_FORWARDING"
            value_from {
              config_map_key_ref {
                name = kubernetes_secret_v1.keycloak_secret.metadata.0.name
                key = "PROXY_ADDRESS_FORWARDING"
              }
            }
          }           
                                                                                                                                                                                                                            
        }
      }
    }      
  }
  
}