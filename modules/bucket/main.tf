provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.bucket-name
}