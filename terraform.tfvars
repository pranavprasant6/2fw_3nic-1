#project_id        = "mygcp-patest"
auth_file         = "authfile.json"
region            = "us-central1"

fw_panos          = "bundle1-909" 

subnet_mgmt       = "mgmt" 
subnet_untrust    = "untrust"
subnet_trust      = "trust"

#fw_panos         = "byol-904" <or> "bundle1-904"  <or> "bundle2-904" 
fw_names          = ["vmseries01-a", "vmseries02-b"]
fw_machine_type   = "n1-standard-4"
#public_key_path   = "~/.ssh/gcp-demo.pub"

