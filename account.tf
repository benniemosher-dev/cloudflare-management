resource "cloudflare_account" "ours" {
  name              = var.config.org-name
  type              = "standard"
  enforce_twofactor = true
}
