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
  parent_id = var.parent_folder != "" ? "folders/${var.parent_folder}" : "organizations/${var.org_id}"
 }

data "google_active_folder" "production" {
  display_name = "${var.folder_prefix}-production"
  parent       = local.parent_id
}

data "google_active_folder" "non-production" {
  display_name = "${var.folder_prefix}-non-production"
  parent       = local.parent_id
}

module "folders" {
  count = 2
  source  = "terraform-google-modules/folders/google"
  version = "~> 3.0"

  parent  = [data.google_active_folder.production, data.google_active_folder.non-production]

  names = [
    dirname("${path.cwd}")
  ]

  set_roles = true

  all_folder_admins = var.folder_admins
}