# Contents of user1.hcl:
path "sys/*" {
  capabilities = ["deny"]
}

path "secret/data/user1" {
  capabilities = ["create", "update", "read"]
}
