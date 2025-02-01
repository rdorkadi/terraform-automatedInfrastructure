terraform {
  backend "s3" {
    bucket         = "terraform-auto"
    key            = "stage/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}