resource "aws_launch_configuration" "waste" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "ami-055386f1c336d88c3"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "vikram" {
  name                 = "vikram"
  launch_configuration = "${aws_launch_configuration.waste.name}"
  min_size             = 6
  max_size             = 6
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  tag {
  key = "Name"
  value = "ec2 instance"
  propagate_at_launch = true
}
}

resource "aws_autoscaling_attachment" "vinny" {
  autoscaling_group_name = "${aws_autoscaling_group.vikram.id}"
  alb_target_group_arn   = "${aws_alb_target_group.tiger.arn}"
}
