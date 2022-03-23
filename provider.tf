variable "access_key" {}
variable "secret_key" {}
variable "pemkey" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
}

resource "aws_key_pair" "pemkey" {
  key_name   = "aws-user"
  public_key = var.pemkey
}
