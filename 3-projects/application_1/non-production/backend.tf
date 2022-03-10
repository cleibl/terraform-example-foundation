terraform {
  backend "gcs" {
    bucket = UPDATE_ME
    prefix = "terraform/projects/APP_NAME/ENV"
  }
}
//Test2