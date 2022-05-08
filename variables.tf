###########################
# Global
#############################

variable "project_id" {
  type        = string
  description = "The GCP Project ID associated with the project. It can be set by using TF_VAR_project_id in your ~/.zprofile"
  default     = "vishal-practice-project-343009"
}

variable "namespace" {
  type        = string
  description = "Project name that will be use to identify the resources"
  default     = "devops"
}

variable "stage" {
  type        = string
  description = "Stage/environment name to tag and suffix the infrastructure composants"
  default     = "practice"
}

#############################
# Network
#############################

variable "network_name" {
  type        = string
  description = "Network Name"
  default     = "gke-network"
}

variable "subnets_names" {
  type        = string
  description = "Subnets Names"
  default     = "gke-subnet"
}

#############################
# SG
#############################

variable "protocol" {
  type        = string
  description = "Firewall Rule protocol"
  default     = "tcp"
}

variable "ports" {
  type        = list(string)
  description = "Firewall Rule direction"
  default     = ["30000-32767","9090","8080"]
}

variable "allowed_ips" {
  type        = list(string)
  description = "Firewall Rule allowed IPs"
  default     = ["0.0.0.0/0"]
}


variable "direction" {
  type        = string
  description = "Firewall Rule direction"
  default     = "INGRESS"
}


############################
# Location
#############################

variable "default_region" {
  type        = string
  description = "Default GCP Region where to deploy the infrastructure"
  default     = "us-central1"
}

# variable "default_multi_region_location" {
#   type        = string
#   description = "Default location for multi-regional resources like GCS"
#   default     = "US"
# }

# variable "default_zones" {
#   type        = list(string)
#   description = "Default GCP Zones where to deploy the infrastructure"
#   default     = ["us-east-1-b,us-east-1-c,us-east-1-d"]
# }


#############################
# Cluster
#############################

# variable "kubernetes_version" {
#   type        = string
#   description = "Control Plane Master version"
#   default     = "1.20.8-gke.700"
# }

variable "min_count" {
  type        = number
  description = "Minimum Nodes"
  default     = 1
}

variable "max_count" {
  type        = number
  description = "Maximum Nodes"
  default     = 2
}

variable "preemptible" {
  type        = bool
  description = "Whether to use preemptible nodes"
  default     = true
}

variable "initial_node_count" {
  type        = number
  description = "Initial Nodes count"
  default     = 1
}

variable "default_max_pods_per_node" {
  type        = number
  description = "Default max pods per node"
  default     = 30
}

variable "machine_type" {
  type        = string
  description = "Node Machine Type"
  default     = "n1-standard-2"
}

variable "local_ssd_count" {
  type        = number
  description = "Local SSD disks count"
  default     = 0
}

variable "disk_size_gb" {
  type        = number
  description = "Disk size in GB"
  default     = 50
}

variable "disk_type" {
  type        = string
  description = "Disk type"
  default     = "pd-standard"
}

variable "ip_range_pods_name" {
  type        = string
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}
variable "ip_range_services_name" {
  type        = string
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}

#############################
# Labels
#############################

# variable "labels" {
#   type        = map(string)
#   description = "Default labels to associate to these resources"
#   default = {
#     # Only lowercase keys allowed
#     team      = "devops"
#     terraform = "true"

#   }
# }
