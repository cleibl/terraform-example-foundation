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

org_id = "790475255155"

billing_account = "014B3B-FEFA55-F8DEA8"

group_org_admins = "gcp-organization-admins@cloudfoundationtoolkit.com"

group_billing_admins = "gcp-billing-admins@cloudfoundationtoolkit.com"

default_region = "us-east1"

github_repo = "cleibl/terraform-example-foundation"

// Optional - for an organization with existing projects or for development/validation.
// Uncomment this variable to place all the example foundation resources under
// the provided folder instead of the root organization.
// The variable value is the numeric folder ID
// The folder must already exist.
//parent_folder = "01234567890"