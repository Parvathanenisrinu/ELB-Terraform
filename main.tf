provider "aws" {
  region = "us-east-1"
}

module "my_ec2" {
  source             						 = "./modules/ec2"
  env                						 = "${var.env}"
  vpc_id           						     = "${var.vpc_id}"
  ec2_name      						 	 = "${var.ec2_name}"
  ec2_count  								 = "${var.ec2_count}"
  ami_id      								 = "${var.ami_id}"
  }

module "my_elb" {
  source             						 = "./modules/elb"
  env                						 = "${var.env}"
  elb_name           						 = "${var.elb_name}"
  vpc_id           						     = "${var.vpc_id}"
  instance_port      						 = "${var.instance_port}"
  instance_protocol  						 = "${var.instance_protocol}"
  health_check_targetpath      				 = "${var.health_check_targetpath}"
  s3_enable_for_access_logs_true_or_false	 = "${var.s3_enable_for_access_logs_true_or_false}"
  s3_name_for_access_logs    				 = "${var.s3_name_for_access_logs}"
  }

terraform {
  backend "s3" {
    bucket = "im-srini-demo"
    key    = "prod"
	region = "us-east-1"
  }
}