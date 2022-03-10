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

locals {
  environment_code       = "n"
  env                    = "non-production"
  network_project_id     = data.google_projects.network_host_project.projects[0].project_id
  network_project_number = data.google_project.network_host_project.number
  parent_id              = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
}

data "google_active_folder" "env" {
  display_name = "${var.folder_prefix}-${local.env}"
  parent       = local.parent_id
}

/******************************************
  Network Hub Host Projects
*****************************************/

data "google_projects" "network_host_project" {
  filter = "parent.id:${split("/", data.google_active_folder.env.name)[1]} labels.application_name=shared-vpc-host labels.environment=${local.env} lifecycleState=ACTIVE"
}

data "google_project" "network_host_project" {
  project_id = data.google_projects.network_host_project.projects[0].project_id
}

/******************************************
  Environment
*****************************************/

module "env" {
  source = "../../../modules/env_baseline"
  env                              = local.env
  environment_code                 = local.environment_code
  parent_id                        = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
  org_id                           = var.org_id
  billing_account                  = var.billing_account
  monitoring_workspace_users       = var.monitoring_workspace_users
  project_prefix                   = var.project_prefix
  folder_prefix                    = var.folder_prefix
  members                          = var.members
  restricted_services              = var.restricted_services
  access_context_manager_policy_id = var.access_context_manager_policy_id
  project_number                   = local.network_project_number
  mode                             = var.mode
}
