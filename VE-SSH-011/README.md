## Commands

```
# Vault issuing pki certificates:
vault secrets enable pki
vault write pki/root/generate/internal \
    common_name=my-website.com \
    ttl=8760h

vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \     crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

vault write pki/roles/my-role \
    allowed_domains=my-website.com \
    allow_subdomains=true \
    max_ttl=72h

vault write pki/issue/my-role \
    common_name=www.my-website.com

---
# Vault signing ssh certificates
vault secrets enable -path=ssh-client-signer ssh

# Generate or register existing certificate
vault write ssh-client-signer/config/ca generate_signing_key=true
# Or, if you have your own certificate already...
# vault write ssh-client-signer/config/ca \
#    private_key="..." \
#    public_key="..."

# In the target instance, retrieve and install the certificate:
ssh -i pem ec2-user@IP
# Reading the public key does not require authentication:
curl -o /etc/ssh/trusted-user-ca-keys.pem $VAULT_ADDR/v1/ssh-client-signer/public_key
# Or, using CLI
# vault read -field=public_key ssh-client-signer/config/ca > /etc/ssh/trusted-user-ca-keys.pem

# Add the path to the trusted keys
# /etc/ssh/sshd_config
# ...
TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem

Restart the SSH service to pick up the changes.
```
