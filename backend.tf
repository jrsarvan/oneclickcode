terraform {
  backend "s3" {
    bucket = "terraformstate2504"
    key = "terraform/backendkey"
    region = "ap-south-1"
    
  }
}
