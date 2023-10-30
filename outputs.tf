output codepipeline_arn {
  value = aws_codepipeline.ecs_deploy.arn
  description = "The ARN assigned by AWS to this codepipeline"
}
