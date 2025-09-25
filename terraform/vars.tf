variable "tenancy_ocid" {
  description = "OCID of your tenancy"
  type        = string
}

variable "user_ocid" {
  description = "OCID of the user"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private key file for OCI API authentication"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint of the API key"
  type        = string
}

variable "region" {
  description = "OCI region (e.g., us-ashburn-1)"
  type        = string
  default     = "ca-toronto-1"
}

variable "compartment_id" {
  description = "OCID of the compartment where resources will be created"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for accessing the instance"
  type        = string
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "1"
}

variable "instance_shape" {
  default = "VM.Standard.A1.Flex"
}

variable "instance_ocpus" {
  default = 2
}

variable "instance_shape_config_memory_in_gbs" {
  default = 12
}

variable "vcn_cidr_block" {
  default = "192.168.0.0/16"
}

variable "subnet_cidr_block" {
  default = "192.168.1.0/24"
}
