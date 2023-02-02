provider "aws" {  # Recommended way of defining provider
    region = "us-east-1"
    shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
    // profile = "Dinesh-Tamang"
}


# s3 bucket creation
resource "aws_s3_bucket" "mybucket" {
    bucket = "mybucket-tfcourse-030223"
    
    tags = {
        Environment = "Dev"
    }
}

# s3 bucket access modifer
resource "aws_s3_bucket_acl" "bucketacl" {
    bucket = aws_s3_bucket.mybucket.id
    acl = "private"
}

# uploading file to s3 bucket
resource "aws_s3_object" "myfirstObject" {
    bucket = aws_s3_bucket.mybucket.id
    key = "testfile.txt"
    source = "./testfile.txt"
    etag = md5(file("./testfile.txt"))
}