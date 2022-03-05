locals {
  # @ means the root of a zone, therefore the other labels get no suffix in that case
  label_suffix = var.subdomain == "@" ? "" : ".${var.subdomain}"

  # SimpleLogin MX servers with weights
  mx_weights = {
    "mx1.simplelogin.co." = 10
    "mx2.simplelogin.co." = 20
  }
}

# Verification
resource "digitalocean_record" "verification" {
  # Knock-off conditional
  # Idea taken from https://stackoverflow.com/a/60231673
  count = var.verification != null ? 1 : 0

  domain = var.zone
  name   = var.subdomain
  type   = "TXT"
  value  = "sl-verification=${var.verification}"
}

# MX
resource "digitalocean_record" "mx" {
  for_each = local.mx_weights

  domain   = var.zone
  name     = var.subdomain
  type     = "MX"
  value    = each.key
  priority = each.value
}

# SPF
resource "digitalocean_record" "spf" {
  domain = var.zone
  name   = var.subdomain
  type   = "TXT"
  value  = "v=spf1 include:simplelogin.co -all"
}

# DKIM
resource "digitalocean_record" "dkim" {
  domain = var.zone
  name   = "dkim._domainkey${local.label_suffix}"
  type   = "CNAME"
  value  = "dkim._domainkey.simplelogin.co."
}

# DMARC
resource "digitalocean_record" "dmarc" {
  domain = var.zone
  name   = "_dmarc${local.label_suffix}"
  type   = "TXT"
  value  = "v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s"
}
