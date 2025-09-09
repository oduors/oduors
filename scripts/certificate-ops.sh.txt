# Generate CSR
openssl req -engine cloudhsm -new -key [PRIVATE_KEY_REF] -out root_ca.csr \
    -subj "/C=[COUNTRY]/ST=[STATE]/L=[CITY]/O=[ORGANIZATION]/OU=[ORG_UNIT]/CN=[COMMON_NAME]"

# Self-sign Root CA Certificate
openssl x509 -engine cloudhsm -req -days 3652 -in root_ca.csr \
    -signkey [PRIVATE_KEY_REF] \
    -out root_ca.crt \
    -extensions v3_ca -extfile root_ca.cnf

# Verify certificate
openssl x509 -in root_ca.crt -text -noout
