terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://cerber.ionyxgroup.net:8006/api2/json"
  pm_api_token_id     = "root@pam!terraform"
  pm_api_token_secret = "969606a5-e87d-4b43-bd76-c75e69d438f9"
  pm_tls_insecure     = true
}

resource "proxmox_lxc" "basic" {
  for_each = var.vms

  target_node  = "cerber"
  hostname     = each.value.hostname
  ostemplate   = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
  password     = "main01"
  unprivileged = true
  onboot       = true
  start        = true
  ssh_public_keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQ/4FxIpR1ghwLincd7TnY8gxSnEayfEqUv0JINnMEB"

  features {
    nesting = true
  }

  memory  = "4096"

  rootfs {
    storage = "local"
    size    = "8G"
  }

  dynamic "network" {
    for_each = each.value.ips

    content {
      name   = "eth${index(keys(each.value.ips), network.key)}"
      bridge = network.value.bridge
      ip     = network.value.ip
      gw     = network.value.gateway
      hwaddr = network.value.mac
    }
  }
}
