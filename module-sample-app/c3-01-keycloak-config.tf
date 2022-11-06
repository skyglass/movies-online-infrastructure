 # Resource: Keycloak Config Map
resource "kubernetes_config_map_v1" "keycloak_config_map" {
  depends_on = [var.sample_app_depends_on]  
  metadata {
    name = "keycloak"
  }
  data = {
    "KEYCLOAK_USER" = "admin@keycloak"
    "KEYCLOAK_MGMT_USER" = "mgmt@keycloak"
    "JAVA_OPTS_APPEND" = "-Djboss.http.port=8080"
    "PROXY_ADDRESS_FORWARDING" = "true"
    "KEYCLOAK_HOSTNAME" = "movie.skycomposer.net"
    "KEYCLOAK_LOGLEVEL" = "INFO"
    "ROOT_LOGLEVEL" = "INFO"
    "DB_VENDOR" = "H2"
  }
}