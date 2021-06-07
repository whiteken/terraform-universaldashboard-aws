resource "aws_route53_zone" "projectZone" {
  name = var.myPublicDomain
}

resource "aws_route53_record" "urls" {
  zone_id = aws_route53_zone.projectZone.zone_id

  for_each = toset(var.public_DNS_CNAMES)

  name = each.value
  type = "CNAME"
  ttl  = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "terraform"
  records        = [aws_instance.myec2.public_dns]

  depends_on = [
    aws_instance.myec2
  ]
}