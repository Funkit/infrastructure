variable "linode_ssh_key_label" {
  description = "Linode SSH key label."
  type        = string
}

variable "instance_label" {
  description = "Name of the Linode instance. Must be DNS compatible."
  type        = string
}

variable "instance_type" {
  description = "Type of the Linode instance. Available type can be obtained at https://api.linode.com/v4/linode/types"
  type        = string
}

variable "cloudflare_domain" {
  type = string
}

variable "tags" {
  description = "Tags to set on the instance."
  type        = list
}
