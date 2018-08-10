
output "consul_servers" {
    value = ["${aws_instance.consul.*.public_dns}"]
}

output "listing_api_servers" {
    value = ["${aws_instance.listing-api.*.public_dns}"]
}

output "mongo_servers" {
    value = ["${aws_instance.mongo.*.public_dns}"]
}

output "product_api_servers" {
    value = ["${aws_instance.product-api.*.public_dns}"]
}

output "aws_subnet_ids" {
    value = ["${data.aws_subnet_ids.default.ids}"]
}

output "aws_cidr_blocks" {
    value = ["${data.aws_subnet.default.*.cidr_block}"]
}

output "listing_server_sg" {
    value = "${aws_security_group.listing_server_sg.id}"
}

output "product_server_sg" {
    value = "${aws_security_group.product_server_sg.id}"
}

output "mongo_server_sg" {
    value = "${aws_security_group.mongo_server_sg.id}"
}

output "consul_server_sg" {
    value = "${aws_security_group.consul_server_sg.id}"
}

output "webclient_servers" {
    value = ["${aws_instance.webclient.*.public_dns}"]
}