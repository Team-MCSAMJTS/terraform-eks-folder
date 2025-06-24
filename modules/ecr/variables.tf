variable "ecr_name" {
  description = "Set of ECR repository names"
  type        = set(string)
  default     = []
}

variable "image_mutability" {
  description = "Image tag mutability setting"
  type        = string
  default     = "IMMUTABLE"
}

variable "encrypt_type" {
  description = "Encryption type for ECR"
  type        = string
  default     = "KMS"
}

variable "tags" {
  description = "Tags for the ECR repositories"
  type        = map(string)
  default     = {}
}
