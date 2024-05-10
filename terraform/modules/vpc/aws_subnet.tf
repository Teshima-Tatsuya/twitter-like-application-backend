resource "aws_subnet" "all" {
    for_each = var.vpc_subnet

    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(
        aws_vpc.main.cidr_block,
        each.value.cidr_block_host,
        each.value.cidr_block_bit
    )

    availability_zone = each.value.az

    tags = {
        Name = each.key
    }
}

