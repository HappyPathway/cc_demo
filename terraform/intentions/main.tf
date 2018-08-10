variable "connect_ws" {

}

variable "connect_org" {

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


data "terraform_remote_state" "connect" {
  backend = "atlas"
  config {
    name = "${var.connect_org}/${var.connect_ws}"
  }
}


provider "consul" {
  address    = "${element(data.terraform_remote_state.connect.consul_servers, 0)}:8500"
  datacenter = "${var.consul_dc}"
}


resource "consul_intention" "deny_product" {
    count = "${var.deny_product == true ? 1 : 0}"
    source_name      = "web_client"
    destination_name = "product"
    action           = "deny"
    #datacenter = "${var.consul_dc}"
}

resource "consul_intention" "allow_product" {
    count = "${var.deny_product == true ? 0 : 1}"
    source_name      = "web_client"
    destination_name = "product"
    action           = "allow"
    #datacenter = "${var.consul_dc}"
}

resource "consul_intention" "deny_listing" {
    count = "${var.deny_listing == true ? 1 : 0}"
    source_name      = "web_client"
    destination_name = "listing"
    action           = "deny"
    #datacenter = "${var.consul_dc}"
}

resource "consul_intention" "allow_listing" {
    count = "${var.deny_listing == true ? 0 : 1}"
    source_name      = "web_client"
    destination_name = "listing"
    action           = "allow"
    #datacenter = "${var.consul_dc}"
}
