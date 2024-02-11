variable "pub-key" {
    description = "key to use"
    type = string
    default = ""
}

variable "name" {
    description = "name to use"
    type = string
    default = "web-pf"
  
}

variable "region" {
    description = "region to use"
    type = string
    default = "us-east-1"
  
}

variable "instance-type" {
    description = "instance type to use"
    type = string
    default = "t3.medium"
  
}

variable "instance-name" {
    description = "name to call instance"
    type = map(string)
    default = {
      "name1" = "web1"
      "name2" = "web2"
      "name3" = "web3"
    }
  
}

variable "availability-zone" {
    description = "az to use"
    type = string
    default = "us-east-1a" 
  
}

variable "vpc-cidr" {
    description = "cidr to use"
    type = string
    default = "10.23.0.0/16"
  
}