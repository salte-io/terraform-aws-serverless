variable "role_name" {}
variable "file" {}
variable "function_name" {}
variable "http_method" {}
variable "handler" {}
variable "resource_id" {}
variable "api_id" {}

variable "environment_variables" {
  type = "map"
  default = {
    dummy = "dummy"
  }
}

variable "subnet_ids" {
  type = "list"
  default = []
}

variable "security_group_ids" {
  type = "list"
  default = []
}

variable "tags" {
  type = "map"
  default = {}
}
