module "wif_project" {
  source                      = "terraform-google-modules/project-factory/google"
  version                     = "~> 11.3"
  name                        = "${var.project_prefix}-b-wif"
  random_project_id           = true
  disable_services_on_destroy = false
  folder_id                   = var.folder_id
  org_id                      = var.org_id
  billing_account             = var.billing_account
  activate_apis = [
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "securitycenter.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
  create_project_sa           = false
  labels                      = {
    environment       = "wif"
    application_name  = "wif-bootstrap"
    env_code          = "b"
  }
  lien                        = true
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = module.wif_project.project_id
  pool_id     = "wif-gh-pool"
  provider_id = "wif-gh-provider"
  sa_mapping = {
    "terraform-service-account" = {
      sa_name   = var.terraform_service_account_id
      attribute = "attribute.repository/${var.github_repo}"
    }
  }
}