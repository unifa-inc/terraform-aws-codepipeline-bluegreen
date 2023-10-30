variable service_name {
  type = string
  description = "Service name"
}

variable service_suffix {
  type    = string
  default = ""
  description = "Service suffix"
}

variable trigger_tag {
  default = null
  description = "Tags that trigger codepipeline startup"
}

variable trigger_ecr_repository_name {
  default = null
  description = "ECR repository name that trigger codepipeline startup"
}

variable tags {
  default = null
  description = "Tags"
}

variable artifact_store_bucket {
  type    = string
  default = ""
  description = "Name of the s3 bucket to store the artifact"
}

variable source_action_run_1 {
  default = []
  description = "Action 1 to be run at the source"
}

variable source_action_run_2 {
  default = []
  description = "Action 2 to be run at the source"
}

variable source_action_run_3 {
  default = []
  description = "Action 3 to be run at the source"
}

variable deploy_action_run_1 {
  default = []
  description = "Action 1 to be run at the deploy"
}

variable deploy_action_run_2 {
  default = []
  description = "Action 2 to be run at the deploy"
}

variable deploy_action_run_3 {
  default = []
  description = "Action 3 to be run at the deploy"
}

variable category {
  default = {
    "CodeDeployToECS" = "Deploy",
    "ECS"             = "Deploy",
    "StepFunctions"   = "Invoke",
    "ECR"             = "Source",
    "S3"              = "Source"
  }
  description = "Category name corresponding to provider"
}

variable add_principal_role {
  default = ""
  description = "Additional principal to allow access"
}
