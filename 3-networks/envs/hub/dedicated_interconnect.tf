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

data "google_projects" "interconnect" {
  count  = var.enable_dedicated_interconnect || var.enable_partner_interconnect ? 1 : 0
  filter = "parent.id:${split("/", data.google_active_folder.common.name)[1]} labels.application_name=org-interconnect lifecycleState=ACTIVE"
}

locals {
  interconnect_project_id           = try(data.google_projects.interconnect[0].projects[0].project_id, null)
}

module "dedicated_interconnect" {
  count  = var.enable_dedicated_interconnect ? 1 : 0
  source = "../../modules/dedicated_interconnect"

  org_id        = var.org_id
  parent_folder = var.parent_folder
  vpc_name      = "c-net_hub"

  region1                                 = var.default_region1
  region1_router1_name                    = module.net_hub_shared_vpc[0].region1_router1.name
  region1_interconnect1_candidate_subnets = var.region1_interconnect1_candidate_subnets
  region1_interconnect1_vlan_tag8021q     = var.region1_interconnect1_vlan_tag8021q
  region1_interconnect1                   = "https://www.googleapis.com/compute/v1/projects/${local.interconnect_project_id}/global/interconnects/${var.region1_interconnect1_name}"
  region1_interconnect1_location          = var.region1_interconnect1_location

  region1_router2_name                    = module.net_hub_shared_vpc[0].region1_router2.name
  region1_interconnect2_candidate_subnets = var.region1_interconnect2_candidate_subnets
  region1_interconnect2_vlan_tag8021q     = var.region1_interconnect2_vlan_tag8021q
  region1_interconnect2                   = "https://www.googleapis.com/compute/v1/projects/${local.interconnect_project_id}/global/interconnects/${var.region1_interconnect2_name}"
  region1_interconnect2_location          = var.region1_interconnect2_location

  region2                                 = var.default_region2
  region2_router1_name                    = module.net_hub_shared_vpc[0].region2_router1.name
  region2_interconnect1_candidate_subnets = var.region2_interconnect1_candidate_subnets
  region2_interconnect1_vlan_tag8021q     = var.region2_interconnect1_vlan_tag8021q
  region2_interconnect1                   = "https://www.googleapis.com/compute/v1/projects/${local.interconnect_project_id}/global/interconnects/${var.region2_interconnect1_name}"
  region2_interconnect1_location          = var.region2_interconnect1_location

  region2_router2_name                    = module.net_hub_shared_vpc[0].region2_router2.name
  region2_interconnect2_candidate_subnets = var.region2_interconnect2_candidate_subnets
  region2_interconnect2_vlan_tag8021q     = var.region2_interconnect2_vlan_tag8021q
  region2_interconnect2                   = "https://www.googleapis.com/compute/v1/projects/${local.interconnect_project_id}/global/interconnects/${var.region2_interconnect2_name}"
  region2_interconnect2_location          = var.region2_interconnect2_location

  peer_asn  = var.peer_asn
  peer_name = var.peer_name

  cloud_router_labels = {
    vlan_1 = "cr1",
    vlan_2 = "cr2",
    vlan_3 = "cr3",
    vlan_4 = "cr4"
  }
}
