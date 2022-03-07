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

module "production_project" {
  source                      = "../../modules/single_project"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = data.google_active_folder.env.name
  environment                 = "production"
  vpc_type                    = "base"
  alert_spent_percents        = var.alert_spent_percents
  alert_pubsub_topic          = var.alert_pubsub_topic
  budget_amount               = var.budget_amount
  project_prefix              = var.project_prefix
  enable_hub_and_spoke        = var.enable_hub_and_spoke
  sa_roles                    = ["roles/editor"]
  enable_cloudbuild_deploy    = false
  cloudbuild_sa               = var.app_infra_pipeline_cloudbuild_sa
  activate_apis = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]

  # Metadata
  project_suffix    = var.prod_metadata["project_suffix"]
  application_name  = var.prod_metadata["application_name"]
  billing_code      = var.prod_metadata["billing_code"]
  primary_contact   = var.prod_metadata["primary_contact"]
  secondary_contact = var.prod_metadata["secondary_contact"]
  business_code     = var.prod_metadata["business_code"]
}


module "non_production_project" {
  source                      = "../../modules/single_project"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = data.google_active_folder.env.name
  environment                 = "non-production"
  vpc_type                    = "base"
  alert_spent_percents        = var.alert_spent_percents
  alert_pubsub_topic          = var.alert_pubsub_topic
  budget_amount               = var.budget_amount
  project_prefix              = var.project_prefix
  enable_hub_and_spoke        = var.enable_hub_and_spoke
  sa_roles                    = ["roles/editor"]
  enable_cloudbuild_deploy    = true
  cloudbuild_sa               = var.app_infra_pipeline_cloudbuild_sa
  activate_apis = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]

  # Metadata
  project_suffix    = var.non_prod_metadata["project_suffix"]
  application_name  = var.non_prod_metadata["application_name"]
  billing_code      = var.non_prod_metadata["billing_code"]
  primary_contact   = var.non_prod_metadata["primary_contact"]
  secondary_contact = var.non_prod_metadata["secondary_contact"]
  business_code     = var.non_prod_metadata["business_code"]
}
