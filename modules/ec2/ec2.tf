#Declare the data source
data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}
data "aws_subnet_ids" "subnetslist" {
  vpc_id = "${data.aws_vpc.selected.id}"
}

resource "aws_instance" "web" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${lookup(var.instance_type,var.env)}"
  subnet_id     = "${var.subnet_id}"
  tags ={
    Name = "${var.env}-${var.ec2_name}-${count.index +1}"
	Env = "${var.env}"
  }
}
