module "fleet_sg" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.gcp_network.network_name
  rules = [{
    name                    = "${var.namespace}-nodeport-sg-${var.stage}"
    description             = "Allow ingress traffic for NodePort services"
    direction               = var.direction
    priority                = null
    ranges                  = var.allowed_ips
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = var.protocol
      ports    = var.ports
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }

  }]
}