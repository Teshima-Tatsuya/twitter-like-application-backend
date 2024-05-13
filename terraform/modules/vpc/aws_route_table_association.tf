resource "aws_route_table_association" "all" {
    for_each = var.vpc_route

    route_table_id = aws_route_table.all[each.key].id
    subnet_id = aws_subnet.all[each.value.subnet].id
}