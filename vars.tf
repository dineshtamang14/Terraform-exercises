variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    jenkins = "ami-0ee23bfc74a881de5"
    sonar   = "ami-0149b2da6ceec4bb0"
    nexus   = "ami-09d3b3274b6c5d4aa"
  }
}

variable "SG" {
  type = map(any)
  default = {
    jenkins = "sg-0eb600aa6ac4e7b1e"
    nexus   = "sg-0917059ab4119fad2"
    sonar   = "sg-0e3d6a4e659198775"
  }
}

variable "VMS" {
  type    = list(any)
  default = ["jenkins", "nexus", "sonar"]
}