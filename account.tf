resource "cloudflare_account" "ours" {
  name = var.config.org-name
  # `type` is deprecated in provider v5 ("should no longer be set
  # through the API") — dropped rather than carried forward.

  # enforce_twofactor moved under settings in provider v5 — this
  # resource has been out of sync with the pinned ~> 5.0 provider since
  # that bump (discovered while adding tunnels.tf/access.tf).
  settings = {
    enforce_twofactor = true
  }
}
