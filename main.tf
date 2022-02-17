locals {
  zone = data.google_compute_zones.available.names
  #   #stage = terraform.workspace == "default" ? var.default_stage : terraform.workspace
  #   common_labels = merge(var.labels, {
  #     # Only lowercase keys allowed
  #     "project"     = var.namespace,
  #     "environment" = local.stage
  #   })
}


#############################
# GKE
#############################S

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.default_region
}


module "gke_auth" {
  source       = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  depends_on   = [module.gke]
  project_id   = var.project_id
  location     = module.gke.location
  cluster_name = module.gke.name
}
resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-${var.stage}"
}

module "gcp_network" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 4.0.1"
  project_id   = var.project_id
  network_name = "${var.network_name}-${var.stage}"
  subnets = [
    {
      subnet_name   = "${var.subnets_names}-${var.stage}"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.default_region
    },
  ]
  secondary_ranges = {
    "${var.subnets_names}-${var.stage}" = [
      {
        range_name    = "${var.ip_range_pods_name}-${var.stage}"
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = "${var.ip_range_services_name}-${var.stage}"
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "18.0.0"

  # Global
  project_id = var.project_id

  # GKE
  name              = "${var.namespace}-gke-cluster-${var.stage}"
  regional          = true
  region            = var.default_region
  zones             = data.google_compute_zones.available.names
  network           = module.gcp_network.network_name
  subnetwork        = module.gcp_network.subnets_names[0]
  ip_range_pods     = "${var.ip_range_pods_name}-${var.stage}"
  ip_range_services = "${var.ip_range_services_name}-${var.stage}"

  # Node Pools
  node_pools = [
    {
      name         = "default-node-pool"
      machine_type = var.machine_type
      #node_locations  = "us-east-1-c,us-east-1-b,us-east-1-d"
      node_locations  = join(",", local.zone)
      min_count       = var.min_count
      max_count       = var.max_count
      local_ssd_count = var.local_ssd_count
      disk_size_gb    = var.disk_size_gb
      disk_type       = var.disk_type
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = false
      #service_account           = google_service_account.gsa.email
      preemptible               = var.preemptible
      initial_node_count        = var.initial_node_count
      default_max_pods_per_node = var.default_max_pods_per_node
    },
  ]


  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "node-pool-01"
    }
  }


  # Firewall rules
  node_pools_tags = {
    all = [
      "https-server",
      "jenkins"
    ]

    default-node-pool = [
      "default-node-pool"
    ]
  }

  # Inbound ports
  add_master_webhook_firewall_rules = true
  firewall_inbound_ports = [
    "15017", # Istio: Pilot
    "9443"   # Istio: Sidecar Webhook
  ]

  #master_authorized_networks = var.master_authorized_networks
}

# data "google_container_cluster" "gke" {
#   name     = module.gke.name
#   location = module.gke.region
# }
