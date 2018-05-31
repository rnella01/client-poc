#Contents of tenant1-readonly.hcl
path "tenant1/*" {
  capabilities = ["read"]
}
