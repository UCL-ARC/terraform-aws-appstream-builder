# terraform-aws-appstream-builder

⚠️ This repository is still under construction! ⚠️

A Terraform instantiation of the CloudFormation workflow from blog post: 
[Automatically create customized AppStream 2.0 Linux images](https://aws.amazon.com/blogs/desktop-and-application-streaming/automatically-create-customized-appstream-2-0-linux-images/).

## Usage

_TODO_

This does not run from end-to-end (yet?) due to manual steps required to configure
the base image builder.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.51.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.51.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.6.1 |
| <a name="module_template_files"></a> [template\_files](#module\_template\_files) | hashicorp/dir/template | 1.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_appstream_image_builder.image_builder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appstream_image_builder) | resource |
| [aws_cloudformation_stack.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_s3_object.zip_files](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_ssm_parameter.as2_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_subnets.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_name"></a> [base\_name](#input\_base\_name) | n/a | `string` | `"Linux_Builder_Base"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | `"as2"` | no |
| <a name="input_builder_instance_type"></a> [builder\_instance\_type](#input\_builder\_instance\_type) | n/a | `string` | `"stream.standard.medium"` | no |
| <a name="input_default_image_name"></a> [default\_image\_name](#input\_default\_image\_name) | n/a | `string` | `"Linux_Automation_Base"` | no |
| <a name="input_image_private_key"></a> [image\_private\_key](#input\_image\_private\_key) | RSA private key to access instance | `string` | `""` | no |
| <a name="input_notification_email"></a> [notification\_email](#input\_notification\_email) | email address to send pipeline notifications to | `string` | n/a | yes |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | n/a | `string` | `"AppStream2-Linux-Pipeline"` | no |
| <a name="input_starter_image_name"></a> [starter\_image\_name](#input\_starter\_image\_name) | n/a | `string` | `"AppStream-AmazonLinux2-03-15-2023"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.

---
<!-- END_TF_DOCS -->
