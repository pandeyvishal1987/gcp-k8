#############################
# GKE
#############################

# Create the Service Account for Kubernetes Nodes
resource "google_service_account" "gsa" {
  account_id = "${var.namespace}-gsa-${var.stage}"
  project    = var.project_id
}

# Attach the Kubernetes Admin role
# resource "google_project_iam_member" "iam_gke_admin" {
#   project = var.project_id
#   role    = "roles/container.admin"
#   member  = "serviceAccount:${google_service_account.gsa.email}"
# }

# Attach the Metrics roles
# resource "google_project_iam_member" "iam_metrics_writer" {
#   project = var.project_id
#   role    = "roles/monitoring.metricWriter"
#   member  = "serviceAccount:${google_service_account.gsa.email}"
# }

# resource "google_project_iam_member" "iam_metrics_viewer" {
#   project = var.project_id
#   role    = "roles/monitoring.viewer"
#   member  = "serviceAccount:${google_service_account.gsa.email}"
# }

# # Attach the Logs role
# resource "google_project_iam_member" "iam_logs_writer" {
#   project = var.project_id
#   role    = "roles/logging.logWriter"
#   member  = "serviceAccount:${google_service_account.gsa.email}"
# }

# # Attach the Logs role
# resource "google_project_iam_member" "iam_stackdriver_writer" {
#   project = var.project_id
#   role    = "roles/stackdriver.resourceMetadata.writer"
#   member  = "serviceAccount:${google_service_account.gsa.email}"
# }

# # Attach the Storage Admin Bucket role
# resource "google_storage_bucket_iam_member" "iam_registry_admin" {
#   bucket = google_container_registry.registry.id
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.gsa.email}"
# }

# #############################
# # Kubernetes
# #############################

# resource "kubernetes_service_account" "ksa" {
#   automount_service_account_token = true
#   metadata {
#     name      = "${var.namespace}-ksa-${var.stage}"
#     namespace = "${var.namespace}-${var.stage}"
#   }
# }

# #############################
# # Databases
# #############################

# resource "google_service_account" "gsa_db" {
#   account_id = "${var.namespace}-gsa-db-${var.stage}"
#   project    = var.project_id
# }

# resource "google_project_iam_member" "iam_cloud_sql_client" {
#   project = var.project_id
#   role    = "roles/cloudsql.client"
#   member  = "serviceAccount:${google_service_account.gsa_db.email}"
# }

# resource "google_service_account_key" "db_key" {
#   service_account_id = google_service_account.gsa_db.name
# }


# module "db_credentials" {
#   source = "../config"

#   # Network
#   cluster_endpoint       = module.gke.endpoint
#   cluster_ca_certificate = module.gke.ca_certificate

#   # Secret
#   secret_name = "${var.namespace}-db-credentials-${var.stage}"

#   secret_data = {
#     "keycloak-db-credentials.json" = base64decode(google_service_account_key.db_key.private_key)
#   }
# }

# #############################
# # Registry
# #############################

# # Get the Registry Service account from the DEV env to allow access from the other envs.
# # This avoid to rebuild the same Docker images on each env by just pulling the DEV images
# # and tag them for each env.
# # TODO

# resource "random_id" "registry_iam_role" {
#   byte_length = 2
# }

# resource "google_service_account" "gsa_registry" {
#   account_id = "${var.namespace}-gsa-registry-${var.stage}"
#   project    = var.project_id
# }

# resource "google_storage_bucket_iam_member" "gsa_registry_iam_admin" {
#   bucket = google_container_registry.registry.id
#   role   = "roles/storage.admin"
#   member = "serviceAccount:${google_service_account.gsa_registry.email}"
# }

# #############################
# # Buckets (GCS)
# #############################

# resource "google_service_account" "gsa_gcs" {
#   account_id = "${var.namespace}-gsa-gcs-${var.stage}"
#   project    = var.project_id
# }

# resource "google_project_iam_custom_role" "iam_cloud_gcs_admin_create" {
#   role_id     = "GCSBucketCreator"
#   title       = "GCS Bucket Creator"
#   description = "Allow user to create Buckets, because roles/storage.admin doesn't works"
#   permissions = [
#     "storage.buckets.create",
#     "storage.buckets.delete",
#     "storage.buckets.get",
#     "storage.buckets.getIamPolicy",
#     "storage.buckets.list",
#     "storage.buckets.setIamPolicy",
#     "storage.buckets.update",
#     "storage.hmacKeys.create",
#     "storage.hmacKeys.delete",
#     "storage.hmacKeys.get",
#     "storage.hmacKeys.list",
#     "storage.hmacKeys.update",
#     "storage.multipartUploads.abort",
#     "storage.multipartUploads.create",
#     "storage.multipartUploads.list",
#     "storage.multipartUploads.listParts",
#     "storage.objects.create",
#     "storage.objects.delete",
#     "storage.objects.get",
#     "storage.objects.getIamPolicy",
#     "storage.objects.list",
#     "storage.objects.setIamPolicy",
#     "storage.objects.update"
#   ]
# }

# # resource "google_project_iam_member" "iam_cloud_gcs_admin" {
# #   project = var.project_id
# #   role    = "roles/storage.admin"
# #   member  = "serviceAccount:${google_service_account.gsa_gcs.email}"
# # }

# resource "google_project_iam_member" "iam_cloud_gcs_bucket_creator" {
#   project = var.project_id
#   role    = google_project_iam_custom_role.iam_cloud_gcs_admin_create.name
#   member  = "serviceAccount:${google_service_account.gsa_gcs.email}"
# }

# resource "google_service_account_key" "gcs_admin_key" {
#   service_account_id = google_service_account.gsa_gcs.name
# }

# module "gcs_credentials" {
#   source = "../config"

#   # Network
#   cluster_endpoint       = module.gke.endpoint
#   cluster_ca_certificate = module.gke.ca_certificate
#   k8s_namespace          = "${var.namespace}-${var.stage}"

#   # Secret
#   secret_name = "${var.namespace}-gcs-credentials-${var.stage}"
#   secret_data = {
#     "credentials.json" = base64decode(google_service_account_key.gcs_admin_key.private_key)
#   }
# }
