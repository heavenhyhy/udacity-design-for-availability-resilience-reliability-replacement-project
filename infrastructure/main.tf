terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  alias  = "active"
  region  = "us-east-1"
}

provider "aws" {
  alias  = "standby"
  region = "us-west-2"
}
