resource "proxmox_vm_qemu" "stg_duy_1" {
  name = "stg.enigma.com.vn"
  desc = "Ubuntu Server 20.04"
  vmid = 100
  target_node = "proxmox"

  clone = var.template_name
  cores = 3
  sockets = 1
  cpu = "host"
  memory = 4096
  
  network {
    bridge = "vmbr0"
    model = "virtio"
    macaddr = "36:0e:cb:67:56:f9"
  }

  disk {
    storage = "local-lvm"
    type = "scsi"
    size = "32G"
  }

  nameserver = "dns.enigma.com.vn"
  sshkeys = <<EOF
    var.ssh_key
  EOF
}

resource "null_resource" "staging_1_remote_bash" {

  provisioner "file" {
    source      = "./staging"
    destination = "/tmp/staging"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "echo 'hello'",
  #   ]
  # }

  connection {
    host     = "192.168.1.254"
    type     = "ssh"
    user     = "duy"
    password = "1"
    agent    = "false"
  }
}
