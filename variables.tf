variable "public_subnet_cidr" {
  type    = set(string)
  default = ["192.168.0.0/24", "192.168.1.0/24"]
}

variable "private_subnet_cidr" {
  type    = set(string)
  default = ["192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
}

variable "private_subnet_cidrs" {
  type = map(list(string))
  default = {
    "us-east-1a" = ["192.168.2.0/24", "192.168.3.0/24"]
    "us-east-1b" = ["192.168.4.0/24", "192.168.5.0/24"]
  }
}

variable "public_subnet_cidrs" {
  type = map(list(string))
  default = {
    "us-east-1a" = ["192.168.0.0/24"]
    "us-east-1b" = ["192.168.1.0/24"]
  }
}


