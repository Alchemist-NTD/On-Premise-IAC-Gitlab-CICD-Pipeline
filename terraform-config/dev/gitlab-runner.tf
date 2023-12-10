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
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+OaDIAozboLA3bjGYoe93ELdS9wTSEp4RpXtidz9vlkoPrjyqfWKO9QbO6NgQuZqGHtVyXPmMR0k5rI1VWXEjoAY7mOavizbyGWmKQhFxYu/FAS+ko2q9YdMGOgDUV5teMHQkgLMK9U1fzbT52S2REflh3dNyiAG5ihEAXwuScBI5z/LvQtrs0DzkXnKyKm0+4PHWE3BdsS313F5b3cqvrkIWVUoAL2QT9GRgbDy1RfUHhgy/OtfxIJr4ckEJZ2xfvJY1YtSZ2YrjbjxKixXMqtsFGodQN3Uz4i8WMB0O0z9ewpvzHHXqphjJfq9K2cFO7jtEkR7XU6nZBsEcx3epW5+vRa9rqYGE+STQI9nqF8NmjdhXn9ORHXAboQLjPfEQ5SCF8ZETSczfDfmLstQxRps+VAv2eUZg6D6j6Ft2syVtOUQQ/4tLJyzvRcsjtK/l14okH2ARByVzueFZVwSWd+TkSbIi9gP1/jpFA5rEM/xtEl3miKfNXeKLP+WJ+es= duy@duy
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