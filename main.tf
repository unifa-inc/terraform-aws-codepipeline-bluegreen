locals {
  service_name = var.service_suffix == "" ? var.service_name : format("%s-%s", var.service_name, var.service_suffix)
}

resource aws_codepipeline ecs_deploy {
  name     = local.service_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.artifact_store_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    dynamic action {
      for_each = var.source_action_run_1
      content {
        name             = action.value["name"]
        category         = var.category[action.value["provider"]]
        owner            = "AWS"
        provider         = action.value["provider"]
        output_artifacts = action.value["output_artifacts"]
        namespace        = action.value["namespace"]
        run_order        = 1
        version          = 1

        role_arn = lookup(action.value, "role_arn", null)

        configuration = action.value["configuration"]
      }
    }

    dynamic action {
      for_each = var.source_action_run_2
      content {
        name             = action.value["name"]
        category         = var.category[action.value["provider"]]
        owner            = "AWS"
        provider         = action.value["provider"]
        output_artifacts = action.value["output_artifacts"]
        run_order        = 2
        version          = 1

        role_arn = lookup(action.value, "role_arn", null)

        configuration = action.value["configuration"]
      }
    }

    dynamic action {
      for_each = var.source_action_run_3
      content {
        name             = action.value["name"]
        category         = var.category[action.value["provider"]]
        owner            = "AWS"
        provider         = action.value["provider"]
        output_artifacts = action.value["output_artifacts"]
        run_order        = 3
        version          = 1

        role_arn = lookup(action.value, "role_arn", null)

        configuration = action.value["configuration"]
      }
    }
  }

  stage {
    name = "Deploy"

    dynamic action {
      for_each = var.deploy_action_run_1
      content {
        name            = action.value["name"]
        category        = var.category[action.value["provider"]]
        owner           = "AWS"
        provider        = action.value["provider"]
        input_artifacts = action.value["input_artifacts"]
        namespace       = action.value["namespace"]
        run_order       = 1
        version         = 1

        role_arn = lookup(action.value, "role_arn", null)

        configuration = action.value["configuration"]
      }
    }

    dynamic action {
      for_each = var.deploy_action_run_2
      content {
        name            = action.value["name"]
        category        = var.category[action.value["provider"]]
        owner           = "AWS"
        provider        = action.value["provider"]
        input_artifacts = action.value["input_artifacts"]
        namespace       = action.value["namespace"]
        run_order       = 2
        version         = 1

        role_arn = lookup(action.value, "role_arn", null)

        configuration = action.value["configuration"]
      }
    }

    dynamic action {
      for_each = var.deploy_action_run_3
      content {
        name            = action.value["name"]
        category        = var.category[action.value["provider"]]
        owner           = "AWS"
        provider        = action.value["provider"]
        input_artifacts = action.value["input_artifacts"]
        namespace       = action.value["namespace"]
        run_order       = 3
        version         = 1

        configuration = action.value["configuration"]
      }
    }
  }

  tags = var.tags

  depends_on = [aws_iam_role.codepipeline_role]
}

### code pipline
resource aws_iam_role codepipeline_role {
  name = format("pipeline-execute-%s", local.service_name)

  assume_role_policy = var.add_principal_role == "" ? data.aws_iam_policy_document.codepipeline_assume_role_policy.json : data.aws_iam_policy_document.add_role_codepipeline_assume_role_policy.json
}

data aws_iam_policy_document codepipeline_assume_role_policy {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codepipeline.amazonaws.com"
      ]
    }
  }
}

data aws_iam_policy_document add_role_codepipeline_assume_role_policy {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "codepipeline.amazonaws.com"
      ]
    }

    principals {
      type = "AWS"

      identifiers = [
        var.add_principal_role
      ]
    }
  }
}

resource aws_iam_role_policy codepipeline_policy {
  name = format("codepipeline_policy-%s", local.service_name)
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEqualsIfExists": {
          "iam:PassedToService": [
            "cloudformation.amazonaws.com",
            "elasticbeanstalk.amazonaws.com",
            "ec2.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
      }
    },
    {
      "Action": [
        "codedeploy:CreateDeployment",
        "codedeploy:GetApplication",
        "codedeploy:GetApplicationRevision",
        "codedeploy:GetDeployment",
        "codedeploy:GetDeploymentConfig",
        "codedeploy:RegisterApplicationRevision"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "elasticbeanstalk:*",
        "ec2:*",
        "elasticloadbalancing:*",
        "autoscaling:*",
        "cloudwatch:*",
        "s3:*",
        "sns:*",
        "cloudformation:*",
        "ecs:*",
        "states:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "lambda:InvokeFunction",
        "lambda:ListFunctions"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "cloudformation:CreateStack",
        "cloudformation:DeleteStack",
        "cloudformation:DescribeStacks",
        "cloudformation:UpdateStack",
        "cloudformation:CreateChangeSet",
        "cloudformation:DeleteChangeSet",
        "cloudformation:DescribeChangeSet",
        "cloudformation:ExecuteChangeSet",
        "cloudformation:SetStackPolicy",
        "cloudformation:ValidateTemplate"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudformation:ValidateTemplate"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:DescribeImages"
      ],
      "Resource": "*"
    }
  ],
  "Version": "2012-10-17"
}

EOF
}

resource aws_iam_role_policy_attachment ecs_codepipeline_role {
  role       = aws_iam_role.codepipeline_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}