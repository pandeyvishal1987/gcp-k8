terraform {
  required_version = ">= 1.0"

  # Activate the backend only after the first run of the project
  # backend "gcs" {
  #   bucket = "appbuilder-gcp-tfstate-dev"
  #   prefix = "terraform/state"
  # }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.90.1"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.90.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.8.0"
    }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "2.2.0"
    # }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.1.0"
    # }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}
