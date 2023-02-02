# specifying the cloud provider
# for setting up aws cli
# aws configure --profile Dinesh-Tamang

provider "aws" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "Dinesh-Tamang"
}