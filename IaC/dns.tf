resource "aws_route53_zone" "projectZone" {
  name = var.myPublicDomain
}

/*
data "aws_route53_zone" "selected" {
  name         = "${var.myPublicDomain}."
}

resource "aws_route53_record" "SSLProof" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "_0D6B95F19FDED38492DFE3BF5F523312"
  type    = "CNAME"
  ttl     = "5"
  
  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "Managed by Terraform"
  records        = ["37FF124145BF66BAC5115074434AB53D.84881F7732740646C2B2091D446702DF.QRc0L2VQfI.comodoca.com"]
  
  depends_on = [
    aws_instance.myec2
  ]
}
*/

resource "aws_route53_record" "urls" {
  zone_id = aws_route53_zone.projectZone.zone_id
  
  for_each = toset(var.public_DNS_CNAMES)

  name = each.value
  type    = "CNAME"
  ttl     = "5"
  
  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "terraform"
  records        = [aws_instance.myec2.public_dns]
  
  depends_on = [
    aws_instance.myec2
  ]
}