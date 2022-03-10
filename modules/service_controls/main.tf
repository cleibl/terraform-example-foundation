locals {
  parent = var.parent_id
  access_level_name = "alp_${var.environment_code}_members_${random_id.random_access_level_suffix.hex}"
  perimeter_name    = "sp_${var.environment_code}_default_perimeter_${random_id.random_access_level_suffix.hex}"
  bridge_name       = "spb_c_to_${var.environment_code}_bridge_${random_id.random_access_level_suffix.hex}"
}

data "google_projects" "net_hub" {
  filter = "parent.id:${split("/", data.google_active_folder.common.name)[1]} labels.application_name=org-net-hub lifecycleState=ACTIVE"
}

data "google_project" "net_hub" {
  project_id = data.google_projects.net_hub.projects[0].project_id
}

/******************************************
  Folder lookups
*****************************************/

data "google_active_folder" "common" {
  display_name = "${var.folder_prefix}-common"
  parent       = local.parent
}