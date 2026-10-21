terraform {
  required_version = "1.16.6"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.28.1"
    }
  }

  cloud {
    organization = "benniemosher-dev"
    workspaces {
      name = "cloudflare-management"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare-config.api-token
}
