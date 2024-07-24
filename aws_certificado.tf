resource "aws_acm_certificate" "imported_cert" {
  domain_name       = "*.alisriosti.com.br"
  validation_method = "DNS"  
}
