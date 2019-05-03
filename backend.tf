terraform {
  backend "consul" {
    path = "terraform/guestbook"
    access_token = ""
  }
}
