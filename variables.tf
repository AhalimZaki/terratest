variable "pipelineURI" {
  type = string
}

locals {
    resourceGroupName = "rg-ApexMinis-Terraform"
    resourceGroupLocation = "East US"
    keyVaultName = "akv-ApexMinis-Terraform"
    storageAccountName = "terraformapexminis"
    storageContainerName = "tfstate"
    storageContainerNameUi = "tfstate-ui"
    
    common_tags = {
      Application = "ApexMinis"
      CreatedDate = timestamp()
      Owner       =  "Halim Zaki"
      CreatedBy   =  "Halim Zaki"
  }
}