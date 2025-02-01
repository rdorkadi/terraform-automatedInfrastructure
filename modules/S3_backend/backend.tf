terraform {
  backend "s3" {
    bucket         = "terraform-automatedinfrastructure"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}