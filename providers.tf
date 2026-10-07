terraform {
  required_version = "1.16.5"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.27.0"
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
