environment      = "poc"
primary_location = "eastus2"
locations        = ["eastus2"]
subscription_id  = "ecc74148-1a84-4ec7-99bb-d26aba7f9c0d"

address_spaces = {
  "eastus" = "10.0.0.0/16"
}

subnets = {
  "eastus" = {
    "endpoints" = "10.0.1.0/24",
    "app_01"    = "10.0.2.0/24",
    "mysql_01"  = "10.0.3.0/24",
  }
}

tags = {
  Environment = "poc",
  Workload    = "proof-of-concept",
  DeployedBy  = "GitHub-Terraform",
}
