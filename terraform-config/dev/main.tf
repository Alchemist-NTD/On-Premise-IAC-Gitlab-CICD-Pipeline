# variable "cloudinit_template_name" {
#   type = string
# }

# variable "proxmox_node" {
#   type = string
# }

# variable "ssh_key" {
#   type = string
#   sensitive = true
# }

# resource "proxmox_vm_qemu" "k8s-1" {
#   count = 5
#   name = "k"
# }