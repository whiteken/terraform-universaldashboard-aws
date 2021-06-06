variable "admin_password" {
  description = "Windows Administrator password to login as for povisioning"
  default = ""
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = ""
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = ""
}

variable "aws_availability_zone" {
  description = "AWS availibility zone to launch in."
  default     = ""
}

variable "myIP" {
  description = "CIDR block for my IP"
  default     = ""
}

variable "myPublicDomain" {
  description = "Public DNS zone"
  default     = ""
}

variable "public_DNS_CNAMES" {
  type    = list(string)
  default = [""]
}

variable "winrm_IP" {
  description = "IP address (regular IP, not CIDR format) for winrm fw rule in ec2 userdata block"
  default     = ""
}

variable "gitHub_winRM_cert_script" {
  description = "URI for github remoting config script"
  default     = ""
}

variable "UD_version_number" {
  description = "Required version for PowerShell Universal Dashboard module"
  default     = ""
}

