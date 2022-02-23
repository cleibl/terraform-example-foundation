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

terraform_service_account = "org-terraform@prj-b-seed-2334.iam.gserviceaccount.com"

default_region1 = "us-east1"

default_region2 = "us-west1"

// The DNS name of peering managed zone. Must end with a period.
domain = "cloudfoundationtoolkit.com."

// Optional - for an organization with existing projects or for development/validation.
// Must be the same value used in previous steps.
//parent_folder = "000000000000"

// Optional - for an organization who wants to use DEDICATED interconnects for hybrid cloud connectivity
// enable_dedicated_interconnect = true

// Optional - for an organization who wants to use PARTNER interconnects for hybrid cloud connectivity

// enable_partner_interconnect = true
// preactivate_partner_interconnect = true