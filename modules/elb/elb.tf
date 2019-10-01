# ELB creation
#Declare the data source
data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_instances" "getec2" {
  instance_tags = {
    Env = "${var.env}"
  }
  instance_state_names = ["running"]
}

resource "aws_elb" "web" {
  name               = "${var.env}-${var.elb_name}"
  availability_zones = "${data.aws_availability_zones.available.names}"

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.instance_protocol}:${var.instance_port}${var.health_check_targetpath}"
    interval            = 30
  }

  access_logs {
    bucket        = "${var.s3_name_for_access_logs}"
    bucket_prefix = "${var.env}-${var.elb_name}"
    interval      = 60
	enabled       = "${var.s3_enable_for_access_logs_true_or_false}"
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.env}-${var.elb_name}"
  }
}


resource "aws_elb_attachment" "attach" {

  count    = "${length(data.aws_instances.getec2.ids)}"
  elb      = "${aws_elb.web.id}"
  instance = "${data.aws_instances.getec2.ids[count.index]}"

}
