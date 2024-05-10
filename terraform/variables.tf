variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "VPC CIDR"
}

variable "vpc_subnet" {
  default = {
    "subnet-pub-a" = {
      cidr_block_host = 2
      cidr_block_bit  = 2
      az              = "ap-northeast-1a"
    },
    "subnet-pub-c" = {
      cidr_block_host = 2
      cidr_block_bit  = 3
      az              = "ap-northeast-1c"
    },
    "subnet-pri-a" = {
      cidr_block_host = 2
      cidr_block_bit  = 0
      az              = "ap-northeast-1a"
    },
    "subnet-pri-c" = {
      cidr_block_host = 2
      cidr_block_bit  = 1
      az              = "ap-northeast-1c"
    }
  }
}

variable "vpc_route" {
  default = {
    "rt-subnet-pub-a" = {
      subnet = "subnet-pub-a"
      dest_cidr = "0.0.0.0/0"
      igw = true
    },
    "rt-subnet-pub-c" = {
      subnet = "subnet-pub-c"
      dest_cidr = "0.0.0.0/0"
      igw = true
    },
    "rt-subnet-pri-a" = {
      subnet = "subnet-pri-a"
      igw = false
    },
    "rt-subnet-pri-c" = {
      subnet = "subnet-pri-c"
      igw = false
    }
  }
}