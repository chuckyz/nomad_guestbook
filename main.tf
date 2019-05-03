module "redis_master" {
  source = "./modules/redis_master"
}

module "redis_slave" {
  source = "./modules/redis_slave"

  redis_master_service = "${module.redis_master.service_name}"
  slave_count          = "1"
}
 
module "guestbook_frontend" {
  source = "./modules/guestbook_frontend"

  redis_master_service = "${module.redis_master.service_name}"
  redis_slave_service = "${module.redis_slave.service_name}"
}
