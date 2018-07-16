variable "api_id" {
  type        = "string"
  description = "The ID of the API Gateway to deploy to."
}

variable "function_name" {
  type        = "string"
  description = "The name of the lambda function."
}

variable "invoke_arn" {
  type        = "string"
  description = "The ARN used by the API Gateway for invocation."
}

variable "resource_id" {
  type        = "string"
  description = "The ID of the API Gateway Resource."
}

variable "http_method" {
  type        = "string"
  description = "The HTTP method the resource will be available at."
}
