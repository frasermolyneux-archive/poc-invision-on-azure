resource "azurerm_resource_group" "mysql" {
  for_each = toset(var.locations)

  name     = format("rg-mysql-%s-%s-%s", random_id.environment_id.hex, var.environment, each.value)
  location = each.value

  tags = var.tags
}

resource "random_password" "mysql" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_mysql_flexible_server" "mysql" {
  for_each = toset(var.locations)

  name = format("mysql-%s-%s-%s", random_id.environment_id.hex, var.environment, each.value)

  resource_group_name = azurerm_resource_group.mysql[each.value].name
  location            = azurerm_resource_group.mysql[each.value].location

  administrator_login    = "addy"
  administrator_password = random_password.mysql.result

  backup_retention_days = 7

  delegated_subnet_id = azurerm_subnet.mysql_01[each.value].id
  private_dns_zone_id = azurerm_private_dns_zone.dns["mysql"].id
  sku_name            = "GP_Standard_D2ds_v4"
}
