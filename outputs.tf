output "mx_record_ids" {
  value = [for record in digitalocean_record.mx: record.id]
}

output "spf_record_id" {
  value = digitalocean_record.spf.id
}

output "dkim_record_id" {
  value = digitalocean_record.dkim.id
}

output "dmarc_record_id" {
  value = digitalocean_record.dmarc.id
}
