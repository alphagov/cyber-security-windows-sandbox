data "aws_iam_policy_document" "wec_exec_role_trust" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "wec_exec_role_policy" {
  statement {
    sid    = "ListBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.splunk_config_bucket}"
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values = [
        "packages/"
      ]
    }
  }

  statement {
    sid    = "GetObject"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObject*"
    ]

    resources = [
      "arn:aws:s3:::${var.splunk_config_bucket}/packages",
      "arn:aws:s3:::${var.splunk_config_bucket}/packages/*"
    ]
  }

  statement {
    sid    = "AssumeS3DownloadRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/SplunkForwarderRole*"
    ]
  }
}

resource "aws_iam_policy" "wec_exec_role_policy" {
  name     = "WECExecRolePolicy"
  policy   = data.aws_iam_policy_document.wec_exec_role_policy.json
}

resource "aws_iam_role" "wec_exec_role" {
  name               = "WECExecRole"
  assume_role_policy = data.aws_iam_policy_document.wec_exec_role_trust.json
  tags               = merge(local.tags, { name : "WECExecRole" })
}

resource "aws_iam_role_policy_attachment" "wec_exec_role" {
  role       = aws_iam_role.wec_exec_role.name
  policy_arn = aws_iam_policy.wec_exec_role_policy.arn
}

resource "aws_iam_instance_profile" "wec_instance_profile" {
  name = "wec-developer_box_instance_profile"
  role = aws_iam_role.wec_exec_role.name
}

