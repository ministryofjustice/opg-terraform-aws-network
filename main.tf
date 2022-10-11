resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = { name = "${local.name-prefix}-vpc" }
}

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name         = var.dhcp_options_domain_name
  domain_name_servers = var.dhcp_options_domain_name_servers
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = { name = "${local.name-prefix}-internet-gateway" }
}

resource "aws_eip" "nat" {
  count = 3
  vpc   = true
  tags  = { name = "${local.name-prefix}-eip-nat-gateway" }
}

resource "aws_nat_gateway" "gw" {
  count         = 3
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags          = { name = "${local.name-prefix}-nat-gateway-${data.aws_availability_zones.all.names[count.index]}" }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  subnet_ids = concat(
    aws_subnet.public[*].id,
    aws_subnet.application[*].id,
    aws_subnet.data[*].id
  )
}

resource "aws_network_acl_rule" "default_allow_all_egress" {
  network_acl_id = aws_default_network_acl.default.id
  rule_number    = 100
  egress         = true
  protocol       = "all" #tfsec:ignore:aws-ec2-no-excessive-port-access
  icmp_code      = 0
  icmp_type      = 0
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "default_allow_all_ingress" {
  network_acl_id = aws_default_network_acl.default.id
  rule_number    = 100
  egress         = false
  protocol       = "all" #tfsec:ignore:aws-ec2-no-excessive-port-access
  icmp_code      = 0
  icmp_type      = 0
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" #tfsec:ignore:aws-ec2-no-public-ingress-acl
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "default_deny_22_ingress" {
  network_acl_id = aws_default_network_acl.default.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = var.deny_port_22_ingress_enabled ? "deny" : "allow"
  cidr_block     = "0.0.0.0/0" #tfsec:ignore:aws-ec2-no-public-ingress-acl
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "default_deny_3389_ingress" {
  network_acl_id = aws_default_network_acl.default.id
  rule_number    = 130
  egress         = false
  protocol       = "tcp"
  rule_action    = var.deny_port_3389_ingress_enabled ? "deny" : "allow"
  cidr_block     = "0.0.0.0/0" #tfsec:ignore:aws-ec2-no-public-ingress-acl
  from_port      = 3389
  to_port        = 3389
}
