###########################
# Global
#############################

variable "project_id" {
  type        = string
  description = "The GCP Project ID associated with the project. It can be set by using TF_VAR_project_id in your ~/.zprofile"
  default = "vishal-jenkins-project"
}

variable "namespace" {
  type        = string
  description = "Project name that will be use to identify the resources"
  default = "devops"
}

variable "stage" {
  type        = string
  description = "Stage/environment name to tag and suffix the infrastructure composants"
  default = "practice"
}

#############################
# Network
#############################

variable "network_name" {
  type        = string
  description = "Network Name"
}

variable "subnets_names" {
  type        = list(string)
  description = "Subnets Names"
}

############################
# Location
#############################

variable "default_region" {
  type        = string
  description = "Default GCP Region where to deploy the infrastructure"
  default = "us-east1"
}

variable "default_multi_region_location" {
  type        = string
  description = "Default location for multi-regional resources like GCS"
  default     = "US"
}

variable "default_zones" {
  type        = list(string)
  description = "Default GCP Zones where to deploy the infrastructure"
}

variable "default_multi_region_location" {
  type        = string
  description = "Default location for multi-regional resources like GCS"
}

#############################
# Cluster
#############################

variable "kubernetes_version" {
  type        = string
  description = "Control Plane Master version"
  default     = "1.20.8-gke.700"
}

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
  default     = "n1-standard-4"
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

#############################
# Labels
#############################

variable "labels" {
  type        = map(string)
  description = "Default labels to associate to these resources"
  default = {
    # Only lowercase keys allowed
    team         = "devops"
    terraform    = "true"
    
  }
}
