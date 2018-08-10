variable "consul_cluster" {
    type = "string"
    description = "Consul Cluster Address"
}

variable "deny_product" {
    default = false
}

variable "deny_listing" {
    default = false
}
variable "consul_dc" {
  type = "string"
  description = "Consul DataCenter"
  default = "dc1"
}

provider "consul" {
  address    = "${var.consul_cluster}"
  datacenter = "${var.consul_dc}"
}


resource "consul_intention" "deny_product" {
    count = "${var.deny_product == true ? 1 : 0}"
    source_name      = "web_client"
    destination_name = "product"
    action           = "deny"
}

resource "consul_intention" "allow_product" {
    count = "${var.deny_product == true ? 0 : 1}"
    source_name      = "web_client"
    destination_name = "product"
    action           = "allow"
}

resource "consul_intention" "deny_listing" {
    count = "${var.deny_listing == true ? 1 : 0}"
    source_name      = "web_client"
    destination_name = "listing"
    action           = "deny"
}

resource "consul_intention" "allow_listing" {
    count = "${var.deny_listing == true ? 0 : 1}"
    source_name      = "web_client"
    destination_name = "listing"
    action           = "allow"
}
