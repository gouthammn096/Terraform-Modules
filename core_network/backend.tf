terraform {
  backend "s3" {
    key     = "network/network.tfstate"
    region  = ""
    encrypt = true #AES-256 encryption
  }
}
