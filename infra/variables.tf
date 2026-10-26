variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralus"
}

variable "project_name" {
  type    = string
  default = "fleet-health"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "owner" {
  type    = string
  default = "64channel"
}