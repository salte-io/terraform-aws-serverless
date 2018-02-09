[![Terraform](https://img.shields.io/badge/terraform-published-blue.svg)](https://registry.terraform.io/modules/salte-io/serverless/aws)

# Terraform Module: Serverless

> This repository is a [Terraform](https://terraform.io/) Module for simplifying the deployment of Lambda Functions to API Gateway.

## Table of Contents

* [Requirements](#requirements)
* [Dependencies](#dependencies)
* [Usage](#usage)
  * [Module Variables](#module-variables)
* [Author Information](#author-information)

## Requirements

This module requires Terraform version `0.10.x` or newer.

## Dependencies

This module depends on a correctly configured [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html) in your Terraform codebase.

## Usage

```tf
data "aws_iam_role" "role" {
  name = "example-role"
}

resource "aws_api_gateway_rest_api" "api" {
  name = "example-api"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part = "example-resource"
}

resource "aws_lambda_function" "function" {
  filename         = "example-zip-file-name.zip"
  function_name    = "example-function-name"
  role             = "${aws_iam_role.role.arn}"
  handler          = "src/example-file-name.handler"
  source_code_hash = "${base64sha256(file("example-zip-file-name.zip"))}"
  runtime          = "nodejs6.10"

  environment {
    variables {
      some_variable = "some_value"
    }
  }
}

module "serverless" {
  source = "salte-io/serverless/aws"
  version = "1.0.0"

  api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "GET"
  function_name = "example-function-name"
  invoke_arn = "${aws_lambda_function.function.invoke_arn}"
}
```

Then, load the module using `terraform get`.

### Module Variables

Available variables are listed below, along with their default values:

| variable | description |
| -------- | ----------- |
| `api_id` | The ID of the API Gateway to deploy to. |
| `resource_id` | The ID of the API Gateway Resource. |
| `http_method` | The HTTP method the resource will be available at. |
| `function_name` | The name of the lambda function. |
| `invoke_arn` | The ARN used by the API Gateway for invocation. |

## Author Information

This module is currently maintained by the individuals listed below.

* [Ceci](https://github.com/cecilia-sanare)
