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
    subnet_id        = oci_core_subnet.kube_private_subnet.id
    display_name     = "Primaryvnic"
    assign_public_ip = false
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


resource "oci_core_vcn" "kube_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_id
  display_name   = "kube-vcn"
  dns_label      = "kubevcn"
}

# Define the private subnet
resource "oci_core_subnet" "kube_private_subnet" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.kube_vcn.id
  cidr_block     = var.subnet_cidr_block
  display_name   = "kube-private-subnet"
  # Assign a route table that directs traffic through a NAT Gateway or Service Gateway for private access
  # This example assumes a NAT Gateway's route table is already defined or will be defined separately
  route_table_id = oci_core_route_table.kube_private_rt.id 
  # Assign a security list for the private subnet
  security_list_ids = [oci_core_security_list.kube_private_sl.id]
  prohibit_public_ip_on_vnic = true # This is crucial for a private subnet
}

resource "oci_core_route_table" "kube_private_rt" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.kube_vcn.id
  display_name   = "kube_private_rt"

  # Example route rule for internet access via NAT Gateway (replace with your NAT Gateway's OCID)
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.kube_nat_gateway.id 
  }
}

resource "oci_core_internet_gateway" "kube_internet_gateway" {
  compartment_id = var.compartment_id
  display_name   = "kube_internet_gateway"
  vcn_id         = oci_core_vcn.kube_vcn.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.kube_vcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.kube_internet_gateway.id
  }
}
# Define a NAT Gateway (if needed for outbound internet access from private subnet)
resource "oci_core_nat_gateway" "kube_nat_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.kube_vcn.id
  display_name   = "kube_nat_gateway"
}

# Define a security list for the private subnet (example, modify as needed)
resource "oci_core_security_list" "kube_private_sl" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.kube_vcn.id
  display_name   = "kube_private_sl"

  # Ingress rules (example: allow SSH from specific CIDR)
  ingress_security_rules {
    protocol  = "6" # TCP
    source    = "192.168.0.0/16" # Or a more restrictive CIDR
    tcp_options {
      min = 22
      max = 22
    }
  }
  # allowed from my jumpbox in other vcn connected by LPG
  ingress_security_rules {
    protocol  = "6" # TCP
    source    = "10.0.0.0/16" # Or a more restrictive CIDR
    tcp_options {
      min = 22
      max = 22
    }
  }

  # Egress rules (example: allow all outbound traffic)
  egress_security_rules {
    protocol        = "all"
    destination     = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}
