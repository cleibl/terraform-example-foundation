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

variable "env" {
  description = "The environment to prepare (ex. development)"
  type        = string
}

variable "environment_code" {
  type        = string
  description = "A short form of the folder level resources (environment) within the Google Cloud organization (ex. d)."
}

variable "parent_id" {
  description = "The parent folder or org for environments"
  type        = string
}

variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}

variable "monitoring_workspace_users" {
  description = "Google Workspace or Cloud Identity group that have access to Monitoring Workspaces."
  type        = string
}

variable "network_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the networks project"
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "network_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the networks project"
  type        = string
  default     = null
}

variable "network_project_budget_amount" {
  description = "The amount to use as the budget for the networks project"
  type        = number
  default     = 1000
}

variable "monitoring_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the monitoring project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "monitoring_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the monitoring project."
  type        = string
  default     = null
}

variable "monitoring_project_budget_amount" {
  description = "The amount to use as the budget for the monitoring project."
  type        = number
  default     = 1000
}

variable "secret_project_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded for the secrets project."
  type        = list(number)
  default     = [0.5, 0.75, 0.9, 0.95]
}

variable "secret_project_alert_pubsub_topic" {
  description = "The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}` for the secrets project."
  type        = string
  default     = null
}

variable "secret_project_budget_amount" {
  description = "The amount to use as the budget for the secrets project."
  type        = number
  default     = 1000
}

variable "project_prefix" {
  description = "Name prefix to use for projects created."
  type        = string
  default     = "prj"
}

variable "folder_prefix" {
  description = "Name prefix to use for folders created."
  type        = string
  default     = "fldr"
}

variable "enable_network" {
  description = "Flag used to enable or disable network projects for the environment"
  type = bool
  default = true
}

variable "members" {
  type        = list(string)
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
}

variable "restricted_services" {
  type        = list(string)
  description = "List of services to restrict."
}

variable "access_context_manager_policy_id" {
  type        = number
  description = "The id of the default Access Context Manager policy. Can be obtained by running `gcloud access-context-manager policies list --organization YOUR_ORGANIZATION_ID --format=\"value(name)\"`."
}

variable "mode" {
  type        = string
  description = "Network deployment mode, should be set to `hub` or `spoke` when `enable_hub_and_spoke` architecture chosen, keep as `null` otherwise."
  default     = "spoke"
}

variable "project_number" {
  type        = number
  description = "Project number for Restricted Shared VPC. It is the project INSIDE the regular service perimeter."
}
