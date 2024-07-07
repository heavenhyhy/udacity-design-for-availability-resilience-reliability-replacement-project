#### Primary VPC

resource "aws_cloudformation_stack" "primary" {
  name = "Primary"
  parameters = {
    VpcName = "Primary"
    VpcCIDR = "10.5.0.0/16"
    PublicSubnet1CIDR = "10.5.10.0/24"
    PublicSubnet2CIDR = "10.5.11.0/24"
    PrivateSubnet1CIDR = "10.5.20.0/24"
    PrivateSubnet2CIDR = "10.5.21.0/24"
  }
  provider = aws.active

  template_body = file("../../cloudformation/vpc.yaml")
}

#### Secondary VPC
resource "aws_cloudformation_stack" "secondary" {
  name = "Secondary"
  parameters = {
    VpcName = "Secondary"
    VpcCIDR = "10.5.0.0/16"
    PublicSubnet1CIDR = "10.6.10.0/24"
    PublicSubnet2CIDR = "10.6.11.0/24"
    PrivateSubnet1CIDR = "10.6.20.0/24"
    PrivateSubnet2CIDR = "10.6.21.0/24"
  }
  provider = aws.standby

  template_body = file("../../cloudformation/vpc.yaml")
}
