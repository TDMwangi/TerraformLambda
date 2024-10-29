provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}

module "lambda" {
  source = "./modules"
}
