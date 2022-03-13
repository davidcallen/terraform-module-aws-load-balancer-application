variable "name" {
  type    = string
  default = ""
}
variable "internal" {
  description = "If true, the LB will be internal."
  type    = bool
  default = true
}
variable "enable_cross_zone_load_balancing" {
  type    = bool
  default = false
}
variable "ip_address_type" {
  type    = string
  default = "ipv4"
}
variable "security_group_ids" {
  description = "List of Security Group IDs.  Optional - if empty it will create its own default Sec Group."
  type    = list(string)
  default = []
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "enable_deletion_protection" {
  type    = bool
  default = true
}
variable "access_logs" {
  type = map(string)
  default = {
    enabled = false
    bucket = ""
    prefix = ""
  }
}