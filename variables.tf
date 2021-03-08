variable "zone" {
  type        = string
  description = "Existing DigitalOcean DNS zone to create records in."
}

variable "subdomain" {
  type        = string
  default     = "@"
  description = "Subdomain to use. Defaults to root of the zone."
}
