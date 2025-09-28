resource "yandex_vpc_network" "kiitygram_network" {
  name = "kiitygram-network"
} 

resource "yandex_vpc_subnet" "kiitygram_network_sub" {
  name           = "kiitygram-network-sub"
  description    = "KittyGram Subnet Network"
  v4_cidr_blocks = var.yclod_subnet
  zone           = var.ycloud_zone
  network_id     = yandex_vpc_network.kiitygram_network.id
}

resource "yandex_vpc_security_group" "kittygram_network_security_group" {
    name       = "kittygram-network-security-group"
    network_id = yandex_vpc_network.kiitygram_network.id
    egress {
        description    = "Permit ANY"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description    = "Allow HTTP"
        protocol       = "TCP"
        port           = 80
        v4_cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description    = "Allow SSH"
        protocol       = "TCP"
        port           = 22
        v4_cidr_blocks = ["0.0.0.0/0"]
    }
}

data "yandex_compute_image" "kittygram_image" {
    family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "kittygram_vm" {
    name        = var.yclod_vm_name
    hostname    = var.yclod_vm_name
    platform_id = "standard-v3"
    zone        = var.ycloud_zone

    resources {
        cores         = 2
        core_fraction = 20
        memory        = 2
    }

    boot_disk {
        initialize_params {
            type     = "network-hdd"
            image_id = data.yandex_compute_image.kittygram_image.id
            size     = 20
        }
    }

    network_interface {
        security_group_ids = [yandex_vpc_security_group.kittygram_network_security_group.id]
        subnet_id          = yandex_vpc_subnet.kiitygram_network_sub.id
        nat                = true
    }

    metadata = {
        user-data = templatefile("./cloud-init.yml", { USER = var.ycloud_vm_user, vm_ssh_key = var.ycloud_vm_ssh_key }),
        ssh-keys  = var.ycloud_vm_ssh_key
    }
}
