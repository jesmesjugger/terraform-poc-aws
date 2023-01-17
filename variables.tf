variable "vpc_cidr_ip" {

    type = string

    default = "10.0.0.0/16"

}
variable "vpc_cidr_ip_subnet" {
    type = list

    default = ["10.0.0.0/24","10.0.1.0/24"]

}

variable "route_internet" {
    type = string

    default = "0.0.0.0/0"

}
variable "key_name" {
    type = string

    default = "winkey"

}
variable "instancetype" {
    type = string

    default = "t2.micro"

}
variable "subnet" {
    type = list

    default = ["public-subnet", "private-subnet"]

}
variable "routable" {
    type = list

    default = ["public-rtb", "private-rtb"]

}
variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [443, 80,8080, 1100, 3000]
}

variable "aws_access-now" {

    type = string

    default = "secret_key"
  
}

variable "aws_access-id" {

    type = string

    default = "access_id"
  
}
variable "aws_region" {

    type = string

    default = "us-east-1"
  
}
