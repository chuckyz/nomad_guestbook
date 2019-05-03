data "template_file" "redis_master" {
  template = "${file("${path.module}/templates/redis_master.nomad")}"
  
  vars {
    service_name = "${var.service_name}"
  }
}

resource "nomad_job" "redis_master" {
  jobspec = "${data.template_file.redis_master.rendered}"
}
