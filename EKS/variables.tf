variable "controlPlane_subnet_ids" {
  type    = list(string)
}

variable "controlPlane_role_arn" {
  type    = string
}

variable "node_subnet_ids" {
  type    = list(string)
}

variable "node_role_arn" {
  type    = string
}