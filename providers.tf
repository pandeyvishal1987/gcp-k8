provider "google" {
  project     = var.project_id
  region      = var.default_region
  credentials = file("${path.root}/vishal-practice-project.json")
}

# provider "kubernetes" {
#   load_config_file       = false
#   host                   = "https://${module.cluster.endpoint}"
#   token                  = module.cluster.access_token
#   cluster_ca_certificate = base64decode(module.cluster.ca_certificate)
# }
