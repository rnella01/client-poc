# Contents of tenant1.hcl:
path "sys/*" {
  capabilities = ["deny"]
}

path "tenant1/*" {
  capabilities = ["create", "update", "read"]
}
