provider "aws" {
    region = aws_region
}

terraform {
  backend "remote" {
    organization = tf_cloud_organization

    workspaces {
      name = tf_cloud_workspace
    }
  }
}
