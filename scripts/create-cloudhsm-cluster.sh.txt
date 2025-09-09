# Create CloudHSM cluster
aws cloudhsmv2 create-cluster \
    --backup-retention-policy Type=DAYS,Value=7 \
    --hsm-type hsm2.medium \
    --region [REGION] \
    --subnet-ids [SUBNET_ID_1] [SUBNET_ID_2] [SUBNET_ID_3]

# Monitor cluster status
aws cloudhsmv2 describe-clusters \
    --filters clusterIds=[CLUSTER_ID] \
    --query 'Clusters[0].State' \
    --output text
