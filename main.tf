data "google_compute_zones" "available" {}

data "google_compute_subnetwork" "mgmt" {
  name   = var.subnet_mgmt
  region = var.region
}

data "google_compute_subnetwork" "untrust" {
  name   = var.subnet_untrust
  region = var.region
}

data "google_compute_subnetwork" "trust" {
  name   = var.subnet_trust
  region = var.region
}


#-----------------------------------------------------------------------------------------------
# Create bootstrap bucket for firewalls
module "bootstrap_bucket" {
  source        = "./modules/gcp_bootstrap/"
  bucket_name   = "vmseries-bootstrap"
  file_location = "bootstrap_files/common_fw/"
  config        = ["init-cfg.txt"]
  license       = ["authcodes"]
}


#-----------------------------------------------------------------------------------------------
# Create  firewalls
module "vmseries" {
  source = "./modules/vmseries/"
  names  = var.fw_names
  zones = [
    data.google_compute_zones.available.names[0],
    data.google_compute_zones.available.names[1]
  ]
  subnetworks = [
    data.google_compute_subnetwork.untrust.self_link,
    data.google_compute_subnetwork.mgmt.self_link,
    data.google_compute_subnetwork.trust.self_link
  ]
  machine_type          = var.fw_machine_type
  bootstrap_bucket      = module.bootstrap_bucket.bucket_name
  mgmt_interface_swap   = "enable"
  ssh_key               = fileexists(var.public_key_path) ? "admin:${file(var.public_key_path)}" : ""
  image                 = "${var.fw_image}-${var.fw_panos}"
  nic0_public_ip        = true
  nic1_public_ip        = true
  nic2_public_ip        = false
  create_instance_group = false
}

# output "MGMT-FW1" {
#   value = "https://${module.vmseries.nic1_public_ip[0]}"
# }

