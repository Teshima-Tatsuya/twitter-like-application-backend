resource "aws_security_group" "all" {
    for_each = var.vpc_sg
    name = each.key
    description = each.value.description
    vpc_id = aws_vpc.main.id

    tags = {
      Name = each.key
    }
}