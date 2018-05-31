# Commands

```
# Enable a kv backend v1 used by this example:
vault secrets enable -path=kv1 -version=1 kv
vault write kv1/hello value="This is a secret"

# Ensure you have env vars set
# VAULT_TOKEN
# VAULT_ADDR

# Source: https://github.com/ncorrare/vault-java-example
cd vault-java-example
mvn compile
mvn package
cd target
java -jar java-client-example-1.0-SNAPSHOT-jar-with-dependencies.jar
```
Java/Vault sdk documentation:
https://github.com/BetterCloud/vault-java-driver