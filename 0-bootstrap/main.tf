/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*************************************************
  Bootstrap GCP Organization.
*************************************************/
locals {
  parent = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
  org_admins_org_iam_permissions = var.org_policy_admin_role == true ? [
    "roles/orgpolicy.policyAdmin", "roles/resourcemanager.organizationAdmin", "roles/billing.user"
  ] : ["roles/resourcemanager.organizationAdmin", "roles/billing.user"]
}

resource "google_folder" "bootstrap" {
  display_name = "${var.folder_prefix}-bootstrap"
  parent       = local.parent
}

module "seed_bootstrap" {
  source                         = "terraform-google-modules/bootstrap/google"
  version                        = "~> 4.0"
  org_id                         = var.org_id
  folder_id                      = google_folder.bootstrap.id
  project_id                     = "${var.project_prefix}-b-seed"
  state_bucket_name              = "${var.bucket_prefix}-b-tfstate"
  billing_account                = var.billing_account
  group_org_admins               = var.group_org_admins
  group_billing_admins           = var.group_billing_admins
  default_region                 = var.default_region
  org_project_creators           = var.org_project_creators
  sa_enable_impersonation        = true
  parent_folder                  = var.parent_folder == "" ? "" : local.parent
  org_admins_org_iam_permissions = local.org_admins_org_iam_permissions
  project_prefix                 = var.project_prefix

  project_labels = {
    environment       = "bootstrap"
    application_name  = "seed-bootstrap"
    env_code          = "b"
  }

  activate_apis = [
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "securitycenter.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]

  sa_org_iam_permissions = [
    "roles/accesscontextmanager.policyAdmin",
    "roles/billing.user",
    "roles/compute.networkAdmin",
    "roles/compute.xpnAdmin",
    "roles/iam.securityAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/logging.configWriter",
    "roles/orgpolicy.policyAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.folderAdmin",
    "roles/securitycenter.notificationConfigEditor",
    "roles/resourcemanager.organizationViewer",
    "roles/iam.workloadIdentityPoolAdmin",
  ]
}

/******************************************
  Create WIF Project
*******************************************/

module "wif_bootstrap" {
  source                         = "../modules/workload_identity_federation/"
  project_prefix                 = var.project_prefix
  billing_account                = var.billing_account
  org_id                         = var.org_id
  folder_id                      = google_folder.bootstrap.id
  terraform_service_account_id   = module.seed_bootstrap.terraform_sa_name
  github_repo                    = var.github_repo
}

resource "google_billing_account_iam_member" "tf_billing_admin" {
  billing_account_id = var.billing_account
  role               = "roles/billing.admin"
  member             = "serviceAccount:${module.seed_bootstrap.terraform_sa_email}"
}

resource "google_organization_iam_member" "org_tf_compute_security_policy_admin" {
  count  = var.parent_folder == "" ? 1 : 0
  org_id = var.org_id
  role   = "roles/compute.orgSecurityPolicyAdmin"
  member = "serviceAccount:${module.seed_bootstrap.terraform_sa_email}"
}

resource "google_folder_iam_member" "folder_tf_compute_security_policy_admin" {
  count  = var.parent_folder != "" ? 1 : 0
  folder = var.parent_folder
  role   = "roles/compute.orgSecurityPolicyAdmin"
  member = "serviceAccount:${module.seed_bootstrap.terraform_sa_email}"
}

resource "google_organization_iam_member" "org_tf_compute_security_resource_admin" {
  count  = var.parent_folder == "" ? 1 : 0
  org_id = var.org_id
  role   = "roles/compute.orgSecurityResourceAdmin"
  member = "serviceAccount:${module.seed_bootstrap.terraform_sa_email}"
}

resource "google_folder_iam_member" "folder_tf_compute_security_resource_admin" {
  count  = var.parent_folder != "" ? 1 : 0
  folder = var.parent_folder
  role   = "roles/compute.orgSecurityResourceAdmin"
  member = "serviceAccount:${module.seed_bootstrap.terraform_sa_email}"
}