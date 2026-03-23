provider "aws" {
  region = "us-east-2"
}

data "terraform_remote_state" "state_bucket" {
  backend = "s3"

  config = {
    bucket = "amzn-aaron-tf-state-bucket"
    key = "network/terraform.tfstate"
    region = "us-east-2"
  }
}

data "aws_ssm_parameter" "amzn_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ssm_parameter.amzn_linux.value
  instance_type = "t3.micro"
  subnet_id = data.terraform_remote_state.state_bucket.outputs.subnet-id

  tags = {
    Name = var.instance-name
  }
}
