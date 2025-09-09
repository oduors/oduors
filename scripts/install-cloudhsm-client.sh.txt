# Download CloudHSM client
wget https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/Amzn2023/cloudhsm-dyn-latest.amzn2023.x86_64.rpm

# Install client
sudo yum install -y ./cloudhsm-dyn-latest.amzn2023.x86_64.rpm

# Get HSM IP
aws cloudhsmv2 describe-clusters \
    --filters clusterIds=[CLUSTER_ID] \
    --query 'Clusters[0].Hsms[0].EniIp' \
    --output text

# Configure client with HSM IP
sudo /opt/cloudhsm/bin/configure-cli -a [ENI_IP]
