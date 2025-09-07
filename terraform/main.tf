resource "oci_core_instance" "ampere_instance" {
  count                      = var.num_instances
  availability_domain        = data.oci_identity_availability_domain.ad.name
  compartment_id             = var.compartment_id
  display_name               = "KubeInstance${count.index}"
  shape                      = var.instance_shape

  shape_config {
    ocpus = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux_images.images[0].id
  }

# only private ip accesses through bastion or jump host
  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "Primaryvnic"
  # assign_public_ip = true  # Assign a public IP for external access
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
  freeform_tags = {
    "freeformkey${count.index}" = "freeformvalue${count.index}"
  }
}

# Output the public IP of the instance
output "instance_private_ips" {
  value = [oci_core_instance.ampere_instance.*.private_ip]
}
