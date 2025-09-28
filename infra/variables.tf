variable "ycloud_token" {
    description = "Token For Yandex Cloud"
    type        = string
}

variable "ycloud_id" {
    description = "Cloud ID For Yandex Cloud"
    type        = string
}

variable "ycloud_folder_id" {
    description = "Folder ID For Yandex Cloud"
    type        = string
}

variable "ycloud_zone" {
    description = "Zone ID For Yandex Cloud"
    type        = string
}

variable "ycloud_s3_name" {
    description = "S3 Bucket name For Yandex Cloud"
    type        = string
}

variable "ycloud_vm_ssh_key" {
    description = "SSH Key for Virtual Machine"
    type        = string
}

variable "yclod_subnet" {
    description = "CIDR For Subnet Yandex Cloud"
    type        = list(string)
    default     = ["10.2.0.0/16"]
}

variable "yclod_vm_name" {
    description = "Virtual machine name Yandex Cloud"
    type        = string
}
