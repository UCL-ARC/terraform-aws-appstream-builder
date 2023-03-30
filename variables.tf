variable "bucket_name" {
  type    = string
  default = "as2"
}

variable "base_name" {
  type    = string
  default = "Linux_Builder_Base"
}

variable "starter_image_name" {
  type    = string
  default = "AppStream-AmazonLinux2-03-15-2023"
}

variable "builder_instance_type" {
  type    = string
  default = "stream.standard.medium"
}

variable "vpc_id" {
  type = string
}
