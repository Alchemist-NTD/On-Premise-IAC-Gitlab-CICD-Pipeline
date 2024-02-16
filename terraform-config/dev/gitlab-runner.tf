resource "proxmox_vm_qemu" "gitlab_runner_1" {
  name = "registry.enigma.com.vn"
  desc = "Ubuntu Server 20.04"
  vmid = 101
  target_node = "proxmox"

  clone = var.template_name
  cores = 3
  sockets = 1
  cpu = "host"
  memory = 4096
  
  network {
    bridge = "vmbr0"
    model = "virtio"
    macaddr = "72:46:5a:83:38:bd"
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


resource "null_resource" "registry_runner_remote_bash" {

  provisioner "file" {
    source      = "./gitlab-runner"
    destination = "/tmp/gitlab-runner"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /tmp/gitlab-runner/ && echo 1 | sudo -S chmod +x ./runner-installation.sh && ./runner-installation.sh",
    ]
  }

  connection {
    host     = "192.168.1.253"
    type     = "ssh"
    user     = "duy"
    password = "1"
    agent    = "false"
  }
}
