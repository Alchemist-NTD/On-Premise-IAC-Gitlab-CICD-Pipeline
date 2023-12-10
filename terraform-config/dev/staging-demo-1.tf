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
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+OaDIAozboLA3bjGYoe93ELdS9wTSEp4RpXtidz9vlkoPrjyqfWKO9QbO6NgQuZqGHtVyXPmMR0k5rI1VWXEjoAY7mOavizbyGWmKQhFxYu/FAS+ko2q9YdMGOgDUV5teMHQkgLMK9U1fzbT52S2REflh3dNyiAG5ihEAXwuScBI5z/LvQtrs0DzkXnKyKm0+4PHWE3BdsS313F5b3cqvrkIWVUoAL2QT9GRgbDy1RfUHhgy/OtfxIJr4ckEJZ2xfvJY1YtSZ2YrjbjxKixXMqtsFGodQN3Uz4i8WMB0O0z9ewpvzHHXqphjJfq9K2cFO7jtEkR7XU6nZBsEcx3epW5+vRa9rqYGE+STQI9nqF8NmjdhXn9ORHXAboQLjPfEQ5SCF8ZETSczfDfmLstQxRps+VAv2eUZg6D6j6Ft2syVtOUQQ/4tLJyzvRcsjtK/l14okH2ARByVzueFZVwSWd+TkSbIi9gP1/jpFA5rEM/xtEl3miKfNXeKLP+WJ+es= duy@duy
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