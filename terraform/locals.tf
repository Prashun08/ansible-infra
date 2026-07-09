locals {
  worker_vms = {
    web01 = {
      size = "Standard_B2s"
    }

    web02 = {
      size = "Standard_B2s"
    }

  }

  common_tags = {
    Project     = "infra-aiops"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Owner       = "Prashun"
  }

}