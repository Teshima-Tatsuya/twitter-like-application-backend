locals {
  pub = {
    "rt-subnet-pub-a" = {
        dest_cidr = "0.0.0.0/0"
    },
    "rt-subnet-pub-c" = {
        dest_cidr = "0.0.0.0/0"
    }
  }
}

resource "aws_route" "pub" {
    for_each = local.pub

    route_table_id = aws_route_table.all[each.key].id
    destination_cidr_block = each.value.dest_cidr
    gateway_id = aws_internet_gateway.main.id
}