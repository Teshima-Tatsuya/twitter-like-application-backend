terraform {
  cloud {
    hostname = "app.terraform.io"
    organization = "teshima"
    workspaces {
      name = "twitter-like-application"
    }
  }
}