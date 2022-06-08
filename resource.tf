resource "digitalocean_kubernetes_cluster" "k8s_iniciativa" {
  name   = var.k8s_name
  #"k8s-iniciativa"
  region = var.region
  #"nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.22.8-do.1"

  node_pool {
    name       = "premium"
    size       = "s-4vcpu-8gb"
    node_count = 2   
  }
}

variable "do_token" {}
variable "k8s_name" {}
variable "region" {}
resource "local_file" "kube_config" {
    content  = digitalocean_kubernetes_cluster.k8s_iniciativa.kube_config.0.raw_config
    filename = "kube_config.yaml"
}