output "Node1" {
  description = "This is the  Bastion-IP to access Application Server"
  value       = module.node1.public_ip
}
