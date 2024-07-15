variable "vms" {
  type = map(object({
    hostname = string
    ips = map(object({
      bridge  = string
      ip      = string
      gateway = string
      mac     = string
    }))
  }))
  default = {
    "vm1" = {
      hostname = "webserver"
      ips = {
        internet = {
          bridge  = "internet"
          ip      = "dhcp"
          gateway = ""
          mac     = ""
        }
        internal = {
          bridge  = "vmbr0"
          ip      = "10.200.225.1/24"
          gateway = ""
          mac     = ""
        }
        endpoint = {
          bridge  = "vmbr0"
          ip      = "91.121.217.107/24"
          gateway = "54.36.63.254"
          mac     = "02:00:00:24:bf:28"
        }
      }
    }
    "vm2" = {
      hostname = "database"
      ips = {
        internet = {
          bridge  = "internet"
          ip      = "dhcp"
          gateway = ""
          mac     = ""
        }
        internal = {
          bridge  = "vmbr0"
          ip      = "10.200.225.2/24"
          gateway = ""
          mac     = ""
        }
        endpoint = {
          bridge  = "vmbr0"
          ip      = "91.121.217.134/24"
          gateway = "54.36.63.254"
          mac     = "02:00:00:fb:f0:27"
        }
      }
    }
  }
}
