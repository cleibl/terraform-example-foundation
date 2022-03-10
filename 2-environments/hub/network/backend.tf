terraform {
  backend "gcs" {
    bucket = "bkt-b-tfstate-4b42"
    prefix = "terraform/networks/envs/shared"
  }
}
