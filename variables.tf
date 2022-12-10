variable "cloudflare-config" {
  description = "The config to connect Terraform to Cloudflare"
  type = object({
    account-id = optional(string, null)
    api-token  = string
    cidrs      = list(string)
  })
}

variable "config" {
  description = "The config for your organization in Github."
  type = object({
    org-name = string
  })
}
