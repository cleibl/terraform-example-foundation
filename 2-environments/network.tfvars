
#################################
# Common Network Variables
##################################
access_context_manager_policy_id = 000000000000
org_id = "000000000000"
default_region1 = "us-central1"
default_region2 = "us-west1"
// The DNS name of peering managed zone. Must end with a period.
domain = "example.com."
target_name_server_addresses = ["192.168.0.1", "192.168.0.2"]

// Optional - for an organization with existing projects or for development/validation.
// Must be the same value used in previous steps.
//parent_folder = "000000000000"


#################################
# Dedicated Interconnect Variables
##################################
enable_partner_interconnect = false
preactivate_partner_interconnect = false

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