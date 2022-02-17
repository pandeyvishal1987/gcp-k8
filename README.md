# Terraform-K8 cluster creation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 3.90.1 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 3.90.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.8.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.90.1 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_network"></a> [gcp\_network](#module\_gcp\_network) | terraform-google-modules/network/google | ~> 4.0.1 |
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | 18.0.0 |
| <a name="module_gke_auth"></a> [gke\_auth](#module\_gke\_auth) | terraform-google-modules/kubernetes-engine/google//modules/auth | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.iam_gke_admin](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iam_logs_writer](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iam_metrics_viewer](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iam_metrics_writer](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iam_stackdriver_writer](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/project_iam_member) | resource |
| [google_service_account.gsa](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/resources/service_account) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/2.1.0/docs/resources/file) | resource |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/3.90.1/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_max_pods_per_node"></a> [default\_max\_pods\_per\_node](#input\_default\_max\_pods\_per\_node) | Default max pods per node | `number` | `30` | no |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | Default GCP Region where to deploy the infrastructure | `string` | `"us-central1"` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Disk size in GB | `number` | `50` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | Disk type | `string` | `"pd-standard"` | no |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | Initial Nodes count | `number` | `1` | no |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | The secondary ip range to use for pods | `string` | `"ip-range-pods"` | no |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | The secondary ip range to use for services | `string` | `"ip-range-services"` | no |
| <a name="input_local_ssd_count"></a> [local\_ssd\_count](#input\_local\_ssd\_count) | Local SSD disks count | `number` | `0` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Node Machine Type | `string` | `"n1-standard-2"` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | Maximum Nodes | `number` | `2` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | Minimum Nodes | `number` | `1` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Project name that will be use to identify the resources | `string` | `"devops"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Network Name | `string` | `"gke-network"` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | Whether to use preemptible nodes | `bool` | `true` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP Project ID associated with the project. It can be set by using TF\_VAR\_project\_id in your ~/.zprofile | `string` | `"vishal-jenkins-project"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage/environment name to tag and suffix the infrastructure composants | `string` | `"practice"` | no |
| <a name="input_subnets_names"></a> [subnets\_names](#input\_subnets\_names) | Subnets Names | `string` | `"gke-subnet"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
