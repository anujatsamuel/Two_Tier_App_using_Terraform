terraform {
  backend "s3" {
    bucket         = "terraform-backend-demoats"
    key            = "tf-backend/demo-project.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-backend-lock"
  }
}