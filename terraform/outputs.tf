output "worker_public_ips" {
  value = {
    for name, pip in azurerm_public_ip.workers :
    name => pip.ip_address
  }
}