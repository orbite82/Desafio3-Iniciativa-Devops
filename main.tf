terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
  #"dop_v1_97893cf7f13a37b8c1e138ddb6ba5c254348a2e1ebe0a3e1228f142ab5c66dbb"
}