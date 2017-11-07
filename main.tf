resource "aws_lambda_permission" "resource" {
  function_name = "${var.function_name}"
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
  uri = "${var.invoke_arn}"
}

# CORS

module "CORS" {
  source = "github.com/carrot/terraform-api-gateway-cors-module"
  resource_id = "${var.resource_id}"
  rest_api_id = "${var.api_id}"
}
