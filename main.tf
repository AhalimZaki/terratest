provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
name = local.resourceGroupName
location = local.resourceGroupLocation
}

resource "azurerm_storage_account" "example" {
  name                     = local.storageAccountName
  resource_group_name      = azurerm_resource_group.example.name
  location                 = local.resourceGroupLocation
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = local.storageContainerName
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
  #deny_encryption_scope_override = false 
  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_storage_container" "tfstate-ui" {
  name                  = local.storageContainerNameUi
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
  #deny_encryption_scope_override = false 
  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# resource "azurerm_key_vault" "keyvault" {
#   name                        = local.keyVaultName
#   location                    = local.resourceGroupLocation
#   resource_group_name         = azurerm_resource_group.example.name
#   enabled_for_disk_encryption = false
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   sku_name = "standard"

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = [
#       "get",
#     ]

#     secret_permissions = [
#       "get",
#       "list",
#       "set",
#       "delete"
#     ]

#     storage_permissions = [
#       "get",
#     ]
#   }
# }  
resource "azurerm_storage_blob" "example" {
  name                   = "${local.storageAccountName}/default"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.tfstate.name
  type                   = "Block"
  #source                 = "tfstate source"
  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

data "azurerm_client_config" "current" {}

