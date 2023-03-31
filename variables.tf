variable "bucket_name" {
  type    = string
  default = "as2"
}

variable "base_name" {
  type    = string
  default = "Linux_Builder_Base"
}

variable "default_image_name" {
  type    = string
  default = "Linux_Automation_Base"
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

variable "image_private_key" {
  type        = string
  description = "RSA private key to access instance"
  default     = ""
  sensitive   = true
}

variable "notification_email" {
  type        = string
  description = "email address to send pipeline notifications to"
}

variable "pipeline_name" {
  type    = string
  default = "AppStream2-Linux-Pipeline"
}
