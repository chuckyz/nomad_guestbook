job "redis_slave_guestbook" {
  datacenters = ["dc1"]
  type = "service"

  group "redis_slave" {
    count = ${slave_count}
    
    ephemeral_disk {
      size = 300
    }

    
    task "redis" {
      driver = "docker"

      config {
        image = "redis:4"
        volumes = [
          "etc/redis.conf:/etc/redis.conf"
        ]
        args = [
          "/etc/redis.conf"
        ]
        port_map {
          db = 6379
        }
      }

      template {
        data = <<EOH
{{ range service "${redis_master_service}" -}}
slaveof {{ .Address }} {{ .Port }}
{{- end}}
EOH
   
	change_mode = "restart"
	perms = "644"
	destination = "etc/redis.conf"
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
        name = "redis-slave-guestbook"
        tags = ["redis-slave", "guestbook"]
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
