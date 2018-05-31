#Contents of config.hcl
vault {
  #address = "https://vault.hashicorp.demo:8200"
  # token   = "6cbf8b0d-49ff-761c-98c2-6f4151be024b" // May also be specified via the envvar VAULT_TOKEN
  renew_token = false

  ssl {
    enabled = true
    verify  = false
  }
}
