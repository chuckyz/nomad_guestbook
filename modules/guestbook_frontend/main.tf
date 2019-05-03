data "template_file" "guestbook_frontend" {
  template = "${file("${path.module}/templates/guestbook_frontend.nomad")}"

  vars {
    frontend_count = "${var.frontend_count}"
    redis_master = "${var.redis_master_service}"
    redis_slave = "${var.redis_slave_service}" 
  }
}

resource "nomad_job" "guestbook_frontend" {
  jobspec = "${data.template_file.guestbook_frontend.rendered}"
}
