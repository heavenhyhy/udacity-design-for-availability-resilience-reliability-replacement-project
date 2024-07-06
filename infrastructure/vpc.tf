resource "aws_vpc" "primary" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Primary"
  }

  provider = aws.active
}

resource "aws_vpc" "secondary" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Secondary"
  }

  provider = aws.standby
}