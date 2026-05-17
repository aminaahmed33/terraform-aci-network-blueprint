variable "epg_names" {
    type = list(string)
    default = [ "web", "App" ]
  
}
variable "username" {
    default = "admin"
}

variable "password" {
    sensitive = true
  
}