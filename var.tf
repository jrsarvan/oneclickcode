variable AWS_ACCESS_KEY {}
variable AWS_SECRET_KEY {}
variable AWS_REGION {
  default = "ap-south-1"
}
variable AMIS {
  type =  map(string)
  default = {
    ap-south-1 = "ami-03a933af70fa97ad2"
    us-east-1 =  "ami-069aabeee6f53e7bf"
  }

}
variable PUB_KEY_PATH {
  default = "newkey.pub"
}

variable PRIV_KEY_PATH {
  default = "newkey"
}
variable USER {
  default = "ubuntu"
}
