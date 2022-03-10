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

# Access Context Manager

members = ["serviceAccount:org-terraform@prj-b-seed-d0b9.iam.gserviceaccount.com","user:cleibl-admin@cloudfoundationtoolkit.com"]
restricted_services = []
access_context_manager_policy_id = 340469432653
