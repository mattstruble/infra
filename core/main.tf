terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.1.0"
    }

    random = {
      source  = "random"
      version = ">= 3.4.3"
    }
  }
}

resource "random_id" "default" {
  byte_length = 1
}
