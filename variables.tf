variable "project_id" {
  description = "GCP Project ID"
}

variable "auth_file" {
  description = "GCP Project auth file"
}

variable "region" {
  description = "Region for deployment"
}

variable "subnet_mgmt" {
  description = "VM-Series management subnet"
}

variable "subnet_untrust" {
  description = "VM-Series untrust subnet"
}

variable "subnet_trust" {
  description = "VM-Series trust subnet"
}

variable "fw_panos" {
  description = "VM-Series license and PAN-OS (ie: bundle1-814, bundle2-814, or byol-814)"
}

variable "fw_image" {
  default = "https://www.googleapis.com/compute/v1/projects/paloaltonetworksgcp-public/global/images/vmseries"
}

variable "fw_names" {
  type = list(string)
}

variable "fw_machine_type" {
}

variable "public_key_path" {
  description = "Local path to public SSH key.  If you do not have a public key, run >> ssh-keygen -f ~/.ssh/demo-key -t rsa -C admin"
}