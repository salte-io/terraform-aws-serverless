data "aws_iam_role" "role" {
  name = "${var.role_name}"
}

resource "aws_lambda_function" "function" {
  filename         = "${var.file}"
  function_name    = "${var.function_name}"
  role             = "${data.aws_iam_role.role.arn}"
  handler          = "${var.handler}"
  source_code_hash = "${base64sha256(file("${var.file}"))}"
  runtime          = "nodejs6.10"

  environment = {
    variables = "${var.environment_variables}"
  }

  # Add a way of specifying environment variables externally!
}

resource "aws_lambda_permission" "resource" {
  function_name = "${aws_lambda_function.function.function_name}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = "${var.api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.method.http_method}"
  integration_http_method = "${aws_api_gateway_method.method.http_method}"
  type = "AWS_PROXY"
  uri = "${aws_lambda_function.function.invoke_arn}"
}

# CORS

module "CORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_name = "CORS"
  resource_id = "${var.resource_id}"
  rest_api_id = "${var.api_id}"
}
