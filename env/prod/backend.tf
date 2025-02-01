terraform {
  backend "s3" {
    bucket         = "terraform-auto"
    key            = "prod/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}