resource "azurerm_key_vault_secret" "mysql-password" {
  for_each = toset(var.locations)

  name         = format("%s-password", azurerm_mysql_server.mysql[each.value].name)
  value        = random_password.mysql.result
  key_vault_id = azurerm_key_vault.kv[each.value].id
}
