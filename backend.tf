terraform {
  cloud {
    organization = "Funkit"

    workspaces {
      name = "sandbox"
    }
  }
}