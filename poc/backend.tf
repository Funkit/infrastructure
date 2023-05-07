terraform {
  cloud {
    organization = "Funkit"

    workspaces {
      name = "poc"
    }
  }
}