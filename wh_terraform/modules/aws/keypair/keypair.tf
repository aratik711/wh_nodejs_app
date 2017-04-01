variable "key_path" {}
variable "aws_key_name" {}


resource "aws_key_pair" "wh_nodejs_key" {
  key_name   = "${var.aws_key_name}"
  public_key = "${file("${var.key_path}/${var.aws_key_name}.pub")}"
}

