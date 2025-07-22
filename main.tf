provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "test" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "vpc-test"
  }
}

resource "aws_subnet" "test" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "subnet-test"
  }
}

resource "aws_instance" "test" {
  ami           = "ami-02003f9f0fde924ea"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.test.id
  tags = {
    Name = "test"
  }
}
output "instance_type" {
  value = aws_instance.test.instance_type
}
