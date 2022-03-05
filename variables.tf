variable "zone" {
  type        = string
  description = "Existing DigitalOcean DNS zone to create records in."
}

variable "subdomain" {
  type        = string
  default     = "@"
  description = "Subdomain to use. Defaults to root of the zone."
}

variable "verification" {
  type        = string
  default     = null
  sensitive   = true
  description = "Domain ownership verification code. Omit for grandfathered domains that do not have one."
}
