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
  parent = var.parent_id
}

data "google_projects" "net_hub" {
  count  = var.mode == "spoke" ? 1 : 0
  filter = "parent.id:${split("/", data.google_active_folder.common.name)[1]} labels.application_name=org-net-hub lifecycleState=ACTIVE"
}

data "google_project" "net_hub" {
  project_id = data.google_projects.net_hub[0].projects[0].project_id
}
