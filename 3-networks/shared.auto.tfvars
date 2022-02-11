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

// List of IPv4 address of target name servers for the forwarding zone configuration.
// See https://cloud.google.com/dns/docs/overview#dns-forwarding-zones
target_name_server_addresses = ["192.168.0.1", "192.168.0.2"]

enable_partner_interconnect = false
preactivate_partner_interconnect = false
enable_hub_and_spoke = true

#################################
# Dedicated Interconnect Variables
##################################
// Uncomment below if using dedicated interconnect
// Region 1 Interconnect 1
region1_interconnect1_candidate_subnets = ["169.254.0.0/29"]
region1_interconnect1_vlan_tag8021q     = "3931"
region1_interconnect1_name              = "example-interconnect-1"
region1_interconnect1_location          = "las-zone1-770"

// Region 1 Interconnect 2
region1_interconnect2_candidate_subnets = ["169.254.0.8/29"]
region1_interconnect2_vlan_tag8021q     = "3932"
region1_interconnect2_name              = "example-interconnect-2"
region1_interconnect2_location          = "las-zone1-770"

// Region 2 Interconnect 1
region2_interconnect1_candidate_subnets = ["169.254.0.16/29"]
region2_interconnect1_vlan_tag8021q     = "3933"
region2_interconnect1_name              = "example-interconnect-3"
region2_interconnect1_location          = "lax-zone2-19"

// Region 2 Interconnect 2
region2_interconnect2_candidate_subnets = ["169.254.0.24/29"]
region2_interconnect2_vlan_tag8021q     = "3934"
region2_interconnect2_name              = "example-interconnect-3"
region2_interconnect2_location          = "lax-zone1-403"

peer_asn  = "64515"
peer_name = "interconnect-peer"