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
  net_hub_project_id           = try(data.google_projects.net_hub[0].projects[0].project_id, null)
  /*
   * Base network ranges
   */
  net_hub_subnet_primary_ranges = {
    (var.default_region1) = "10.0.0.0/24"
    (var.default_region2) = "10.1.0.0/24"
  }
}

/******************************************
 Network Hub Project
*****************************************/

data "google_projects" "net_hub" {
  count  = var.enable_hub_and_spoke ? 1 : 0
  filter = "parent.id:${split("/", data.google_active_folder.common.name)[1]} labels.application_name=org-net-hub lifecycleState=ACTIVE"
}

/******************************************
 Network Hub VPC
*****************************************/

module "net_hub_shared_vpc" {
  source                        = "../../modules/shared_vpc"
  count                         = var.enable_hub_and_spoke ? 1 : 0
  project_id                    = local.net_hub_project_id
  environment_code              = local.environment_code
  org_id                        = var.org_id
  parent_folder                 = var.parent_folder
  bgp_asn_subnet                = local.bgp_asn_number
  default_region1               = var.default_region1
  default_region2               = var.default_region2
  domain                        = var.domain
  windows_activation_enabled    = var.net_hub_windows_activation_enabled
  dns_enable_inbound_forwarding = var.net_hub_dns_enable_inbound_forwarding
  dns_enable_logging            = var.net_hub_dns_enable_logging
  firewall_enable_logging       = var.net_hub_firewall_enable_logging
  optional_fw_rules_enabled     = var.net_hub_optional_fw_rules_enabled
  nat_enabled                   = var.net_hub_nat_enabled
  nat_bgp_asn                   = var.net_hub_nat_bgp_asn
  nat_num_addresses_region1     = var.net_hub_nat_num_addresses_region1
  nat_num_addresses_region2     = var.net_hub_nat_num_addresses_region2
  folder_prefix                 = var.folder_prefix
  mode                          = "hub"

  subnets = [
    {
      subnet_name           = "sb-c-shared-net-hub-${var.default_region1}"
      subnet_ip             = local.net_hub_subnet_primary_ranges[var.default_region1]
      subnet_region         = var.default_region1
      subnet_private_access = "true"
      subnet_flow_logs      = var.subnetworks_enable_logging
      description           = "Network hub subnet for ${var.default_region1}"
    },
    {
      subnet_name           = "sb-c-shared-net-hub-${var.default_region2}"
      subnet_ip             = local.net_hub_subnet_primary_ranges[var.default_region2]
      subnet_region         = var.default_region2
      subnet_private_access = "true"
      subnet_flow_logs      = var.subnetworks_enable_logging
      description           = "Network hub subnet for ${var.default_region2}"
    }
  ]
  secondary_ranges = {}
}