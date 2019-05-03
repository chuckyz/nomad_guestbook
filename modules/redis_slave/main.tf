data "template_file" "redis_slave" {
  template = "${file("${path.module}/templates/redis_slave.nomad")}"

  vars {
   slave_count = "${var.slave_count}"
   redis_master_service = "${var.redis_master_service}"
   service_name = "${var.service_name}"
  }
}

resource "nomad_job" "redis_slave" {
  jobspec = "${data.template_file.redis_slave.rendered}"
}
