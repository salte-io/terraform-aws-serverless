variable "role_name" {}
variable "file" {}
variable "function_name" {}
variable "http_method" {}
variable "handler" {}
variable "resource_id" {}
variable "api_id" {}

variable "environment_variables" {
  type = "map"
  default = {}
}

variable "vpc_config" {
  type = "map"
}
