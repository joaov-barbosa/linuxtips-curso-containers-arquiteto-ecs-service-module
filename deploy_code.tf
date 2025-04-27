# resource "local_file" "appspec" {
#   count    = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0
#   filename = "${path.module}/${aws_codedeploy_app.main[count.index].name}.yaml"
#   content = templatefile("${path.module}/files/codedeploy/appspec.yaml.tpl", {
#     APPLICATION_NAME    = aws_codedeploy_app.main[count.index].name
#     TASK_DEFINITION_ARN = aws_ecs_task_definition.main.arn
#     CONTAINER_NAME      = var.service_name
#     CONTAINER_PORT      = var.service_port
#     CAPACITY_PROVIDERS  = var.service_launch_type
#   })
# }

# resource "null_resource" "deploy_codedeploy" {
#   count = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0

#   provisioner "local-exec" {
#     command = "aws deploy create-deployment --cli-input-yaml file://${path.module}/${aws_codedeploy_app.main[count.index].name}.yaml"
#     environment = {
#       AWS_REGION = var.region
#     }
#   }

#   triggers = {
#     task_definition = aws_ecs_task_definition.main.revision
#   }

#   depends_on = [
#     aws_ecs_service.main,
#     aws_ecs_task_definition.main,
#     aws_codedeploy_app.main,
#     aws_codedeploy_deployment_group.main,
#     local_file.appspec
#   ]

# }
resource "aws_codedeploy_deployment" "this" {
  count = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0

  application_name      = aws_codedeploy_app.main[count.index].name
  deployment_group_name = aws_codedeploy_deployment_group.main[count.index].deployment_group_name

  revision {
    revision_type = "AppSpecContent"

    app_spec_content {
      content = templatefile("${path.module}/files/codedeploy/appspec.yaml.tpl", {
        APPLICATION_NAME    = aws_codedeploy_app.main[count.index].name
        TASK_DEFINITION_ARN = aws_ecs_task_definition.main.arn
        CONTAINER_NAME      = var.service_name
        CONTAINER_PORT      = var.service_port
        CAPACITY_PROVIDERS  = var.service_launch_type
      })
    }
  }

  depends_on = [
    aws_codedeploy_app.main,
    aws_codedeploy_deployment_group.main,
    aws_ecs_service.main,
    aws_ecs_task_definition.main
  ]
}

