# https://aws.amazon.com/blogs/desktop-and-application-streaming/automatically-create-customized-appstream-2-0-linux-images/

provider "aws" {
  region = "eu-west-2"
}

locals {
  s3_bucket_name  = "${var.bucket_name}-${random_id.id.hex}"
  deploy_pipeline = var.image_private_key == "" ? 0 : 1
}

resource "random_id" "id" {
  byte_length = 5
}

module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.1"

  bucket = local.s3_bucket_name
  acl    = "private"

  versioning = {
    enabled = false
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${path.root}/assets/INSTALL"

}

resource "aws_s3_object" "zip_files" {
  for_each = module.template_files.files

  bucket       = module.bucket.s3_bucket_id
  key          = each.key
  content_type = each.value.content_type

  # The template_files module guarantees that only one of these two attributes
  # will be set for each file, depending on whether it is an in-memory template
  # rendering result or a static file on disk.
  source      = each.value.source_path
  source_hash = filebase64sha256(each.value.source_path)
  content     = each.value.content

}

data "aws_subnets" "selected" {

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

resource "aws_appstream_image_builder" "image_builder" {
  name                           = var.base_name
  description                    = "Base image builder for automation"
  display_name                   = "Base image builder"
  enable_default_internet_access = false
  image_name                     = var.starter_image_name
  instance_type                  = "stream.standard.medium"

  vpc_config {
    subnet_ids = [data.aws_subnets.selected.ids[0]]
  }
}

resource "aws_ssm_parameter" "as2_key" {
  count = local.deploy_pipeline
  name  = "/as2_automation/sshkey"
  type  = "SecureString"
  value = var.image_private_key
}

resource "aws_cloudformation_stack" "pipeline" {
  count = local.deploy_pipeline

  name = var.pipeline_name

  template_body = file("./assets/AS2-Automation-Linux-CloudFormation.yaml")

  parameters = {
    AS2DefaultImage              = var.default_image_name,
    AS2DefaultSSHKeyARN          = aws_ssm_parameter.as2_key[0].arn,
    AS2VPCId                     = var.vpc_id,
    AS2VPCSubnet1                = data.aws_subnets.selected.ids[0],
    AS2VPCSubnet2                = data.aws_subnets.selected.ids[1],
    SNSEmailSubscriptionEndPoint = var.notification_email,
    SourceS3Bucket               = module.bucket.s3_bucket_id
  }

  capabilities = ["CAPABILITY_NAMED_IAM"]
}

