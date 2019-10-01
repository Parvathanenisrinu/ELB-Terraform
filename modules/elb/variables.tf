# ELB creation

#Declare the variables
variable "env" { }
variable "elb_name" { }
variable "vpc_id" { }
variable "instance_port" { }
variable "instance_protocol" { }
variable "health_check_targetpath" { }
variable "s3_name_for_access_logs" { }
variable "s3_enable_for_access_logs_true_or_false" { }

