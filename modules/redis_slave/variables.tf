variable "redis_master_service" { type="string" }

variable "service_name" { 
  type="string" 
  default = "redis-slave-guestbook"
}

variable "slave_count" {
  type = "string"
  default = "1"
}
