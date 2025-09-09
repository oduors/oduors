# Generate Root CA Key Pair
aws-cloudhsm > key generate-asymmetric-pair rsa \
    --public-label RootCA-pub \
    --private-label RootCA-priv \
    --modulus-size-bits 2048 \
    --public-exponent 65537

# Configure key attributes
aws-cloudhsm > key set-attribute \
    --filter key-reference=[PRIVATE_KEY_REF] \
    --name sign --value true

aws-cloudhsm > key set-attribute \
    --filter key-reference=[PUBLIC_KEY_REF] \
    --name verify --value true

# List and verify keys
aws-cloudhsm > key list
aws-cloudhsm > key describe --key-reference=[KEY_REF]
