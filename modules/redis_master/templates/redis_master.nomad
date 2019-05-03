job "redis_master_guestbook" {
  datacenters = ["dc1"]
  type = "service"

  group "redis_master" {
    count = 1
    
    ephemeral_disk {
      size = 300
    }

    
    task "redis" {
      driver = "docker"

      config {
        image = "redis:4"
        port_map {
          db = 6379
        }
      }

      resources {
        cpu    = 100
        memory = 100
        network {
          mbits = 100
          port "db" {}
        }
      }

      service {
        name = "${service_name}"
        tags = ["redis-master", "guestbook"]
        port = "db"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
