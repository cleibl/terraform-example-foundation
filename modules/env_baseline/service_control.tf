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

resource "random_id" "random_access_level_suffix" {
  byte_length = 2
}

module "service_controls" {
  source      = "../service_controls"
  members     = var.members
  restricted_services = var.restricted_services
  access_context_manager_policy_id = var.access_context_manager_policy_id
  mode = var.mode
  project_number = var.project_number
  parent_id = var.parent_id
  env = var.env
  folder_prefix = var.folder_prefix
  environment_code = var.environment_code
}
