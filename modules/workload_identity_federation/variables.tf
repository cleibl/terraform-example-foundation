
variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "folder_id" {
  description = "The ID of the folder which the Workload Identity project should be created under"
  type = string
}

variable "github_repo" {
  description = "The name of the Github Repo which is allowed to impersonate the Terraform Service Account.  Should be in the form of <ORG>/<REPO_NAME> (e.g ScaleSec/terraform-example-foundation)"
  type = string
}

variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "project_prefix" {
  description = "Name prefix to use for projects created. Should be the same in all steps. Max size is 3 characters."
  type        = string
}

variable "terraform_service_account_id" {
  description = "The Resource ID of the terraform service account which the Github Action will be allowed to impersonate"
  type        = string
}
