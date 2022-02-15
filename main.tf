locals {
  stage = terraform.workspace == "default" ? var.default_stage : terraform.workspace
  common_labels = merge(var.labels, {
    # Only lowercase keys allowed
    "project"     = var.namespace,
    "environment" = local.stage
  })
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.default_region
}

#############################
# GKE
#############################S

module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 2.5"
  project_id   = var.project_id
  network_name = "${var.network}-${var.stage}"
  subnets = [
    {
      subnet_name   = "${var.subnetwork}-${var.stage}"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
    },
  ]
  secondary_ranges = {
    "${var.subnetwork}-${var.stage}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  #version = "14.3.0"

  # Global
  project_id = var.project_id

  # GKE
  name                       = "${var.namespace}-gke-cluster-${var.stage}"
  regional               = true
  region                     = var.default_region
  zones                      = data.google_compute_zones.available.names
  network                    =  module.gcp-network.network_name
  subnetwork                 = module.gcp-network.subnets_names[0]
  ip_range_pods              = "gke-slaves-subnet-2-${var.stage}"
  ip_range_services          = "gke-slaves-subnet-3-${var.stage}"
#   http_load_balancing        = true
#   horizontal_pod_autoscaling = true
#   network_policy             = true
#   enable_private_nodes       = true
#   remove_default_node_pool   = true
#   kubernetes_version         = var.kubernetes_version # To avoid unattended updates to version > 1.20.x


  # Node Pools
  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = var.machine_type
      node_locations            = join(",", var.default_zones)
      min_count                 = var.min_count
      max_count                 = var.max_count
      local_ssd_count           = var.local_ssd_count
      disk_size_gb              = var.disk_size_gb
      disk_type                 = var.disk_type
      image_type                = "COS"
      auto_repair               = true
      auto_upgrade              = false
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

  master_authorized_networks = var.master_authorized_networks
}

data "google_container_cluster" "gke" {
  name     = module.gke.name
  location = module.gke.region
}
