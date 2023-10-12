terraform {
    required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
   organization = "devpopa"
   workspaces {
     name = "terra-house-mihai"
   }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_juventus_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.juventus.public_path
  content_version = var.juventus.content_version
}

resource "terratowns_home" "home" {
  name = "Juventus FC"
  description = <<DESCRIPTION
An Italian Icon since 1897
DESCRIPTION
  domain_name = module.home_juventus_hosting.domain_name
  town = "missingo"
  content_version = var.juventus.content_version
}

module "home_partitionguide_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.partitionguide.public_path
  bucket_name = var.bucket_name
  content_version = var.partitionguide.content_version
}

resource "terratowns_home" "home_partitionguide" {
  name = "How to Increase the Size of the Root Partition"
  description = <<DESCRIPTION
This page provides a structured guide on how to increase the size of the root (/) partition, specifically when it's an LVM logical volume.
DESCRIPTION
  domain_name = module.home_partitionguide_hosting.domain_name
  town = "missingo"
  content_version = 1
}