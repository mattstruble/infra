terraform {
  required_version = ">= 1.4.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.1"
    }

    kubernetes = {
      source  = "kubernetes"
      version = "~> 2.18"
    }

    random = {
      source  = "random"
      version = "~> 3.4"
    }
  }
}

# Providers

provider "cloudflare" {}

# Modules

module "core" {
  source = "./core"

  cloudflare_account_id = var.cloudflare_account_id
}
