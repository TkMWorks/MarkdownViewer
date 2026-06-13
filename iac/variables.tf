variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "project" {
  type        = string
  description = "Project"
  default     = "MarkdownViewer"
}

variable "project_owner" {
  type        = string
  description = "Owner of resources in the project"
  default     = "TkM"
}