terraform {
  required_version = "~> 1.3"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.1"
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
