variable "members" {
  type        = list(string)
  description = "An allowed list of members (users, service accounts). The signed-in identity originating the request must be a part of one of the provided members. If not specified, a request may come from any user (logged in/not logged in, etc.). Formats: user:{emailid}, serviceAccount:{emailid}"
}

variable "restricted_services" {
  type        = list(string)
  description = "List of services to restrict."
}

variable "access_context_manager_policy_id" {
  type        = number
  description = "The id of the default Access Context Manager policy. Can be obtained by running `gcloud access-context-manager policies list --organization YOUR_ORGANIZATION_ID --format=\"value(name)\"`."
}

variable "mode" {
  type        = string
  description = "Network deployment mode, should be set to `hub` or `spoke` when `enable_hub_and_spoke` architecture chosen, keep as `null` otherwise."
  default     = "spoke"
}

variable "project_number" {
  type        = number
  description = "Project number for Restricted Shared VPC. It is the project INSIDE the regular service perimeter."
}

variable "parent_id" {
  description = "The parent folder or org for environments"
  type        = string
}

variable "env" {
  description = "The environment to prepare (ex. development)"
  type        = string
}

variable "folder_prefix" {
  description = "Name prefix to use for folders created."
  type        = string
  default     = "fldr"
}

variable "environment_code" {
}
