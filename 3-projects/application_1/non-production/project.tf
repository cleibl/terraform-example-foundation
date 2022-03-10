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

module "project" {
  source                      = "../../../modules/single_project"
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = module.folders.1.id
  environment                 = "non-production"
  vpc_type                    = "base"
  alert_spent_percents        = var.alert_spent_percents
  alert_pubsub_topic          = var.alert_pubsub_topic
  budget_amount               = var.budget_amount
  project_prefix              = var.project_prefix
  enable_hub_and_spoke        = var.enable_hub_and_spoke
  sa_roles                    = ["roles/editor"]
  activate_apis = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "accesscontextmanager.googleapis.com"
  ]

  vpc_service_control_attach_enabled = "true"
  vpc_service_control_perimeter_name = "accessPolicies/${var.access_context_manager_policy_id}/servicePerimeters/${var.perimeter_name}"


  # Metadata
  project_suffix    = var.project_metadata["project_suffix"]
  application_name  = var.project_metadata["application_name"]
  billing_code      = var.project_metadata["billing_code"]
  primary_contact   = var.project_metadata["primary_contact"]
  secondary_contact = var.project_metadata["secondary_contact"]
  business_code     = var.project_metadata["business_code"]
}
