provider "aws" {
    region = "eu-central-1"
}

terraform {
  backend "remote" {
    organization = "citius"

    workspaces {
      name = "streisand-host-aws"
    }
  }
}
