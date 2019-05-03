job "frontend_guestbook" {
  datacenters = ["dc1"]
  type = "service"

  group "frontend" {
    count = ${frontend_count}
    
    ephemeral_disk {
      size = 300
    }

    
    task "frontend" {
      driver = "docker"

      config {
        image = "chuckyz/nomad-guestbook"
        port_map {
          web = 3000
        }
      }

      template {
        data = <<EOH
REDIS_MASTER_HOST={{ range service "${redis_master}" }}{{ .Address }}{{ end }}
REDIS_MASTER_PORT={{ range service "${redis_master}" }}{{ .Port }}{{ end }}
REDIS_SLAVE_HOST={{ range service "${redis_slave}" }}{{ .Address }}{{ end }}
REDIS_SLAVE_PORT={{ range service "${redis_slave}" }}{{ .Port }}{{ end }}
EOH
        env = true 
	destination = "config/hosts.env"
      }

      resources {
        cpu    = 100
        memory = 100
        network {
          mbits = 100
          port "web" {}
        }
      }

      service {
        name = "frontend-guestbook"
        tags = ["frontend", "guestbook"]
        port = "web"
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
