variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "location" {
  description = "Emplacement géographique des ressources"
  type        = string
  default     = "France Central"
}
