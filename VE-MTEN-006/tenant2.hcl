# Contents of tenant2.hcl

path "sys/*" {
  capabilities = ["deny"]
}

path "tenant2/*" {
  capabilities = ["create", "update", "read"]
}
