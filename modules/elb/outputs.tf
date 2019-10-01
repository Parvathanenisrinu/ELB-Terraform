
output "elb_id" {
  value = "${aws_elb.web.id}"
}
output "elb_name" {
  value = "${aws_elb.web.name}"
}
output "elb_arn" {
  value = "${aws_elb.web.arn}"
}
output "elb_dns_name" {
  value = "${aws_elb.web.dns_name}"
}
