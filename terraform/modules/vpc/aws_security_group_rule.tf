locals {
  sg_rules = flatten(
    [for sg_name, value in var.vpc_sg:
      [for rule_name, sg_rule in value.rules: 
        {
          "sg_name" = sg_name
          "rule" = sg_rule
          "rule_name" = rule_name
        }
      ]
    ]
  )
}

resource "aws_security_group_rule" "all" {
  for_each = { for rule in local.sg_rules : "${rule.sg_name}-${rule.rule_name}" => rule }

  type = each.value.rule.type
  description = each.value.rule.description
  security_group_id = aws_security_group.all[each.value.sg_name].id
  from_port = each.value.rule.from
  to_port = each.value.rule.to
  protocol = each.value.rule.protocol
  cidr_blocks = [each.value.rule.cidr]
}