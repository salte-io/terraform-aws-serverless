# Serverless

Terraform module to simplify Serverless Lambda Deployment.

### Example

```tf
module "ServerlessLambda" {
  source = "github.com/nick-woodward/serverless"
  api_id = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.feedback_resource.id}"
  role_name = "example-lambda-role"
  function_name = "example-function-name"
  handler = "example-function.handler"
  file = "example-function.zip"
}
```