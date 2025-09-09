# Create manual backup
aws cloudhsmv2 create-backup \
    --cluster-id [CLUSTER_ID]

# List all backups
aws cloudhsmv2 describe-backups \
    --filters clusterIds=[CLUSTER_ID] \
    --query 'Backups[*].[BackupId,CreateTimestamp,State]' \
    --output table

# Modify backup retention
aws cloudhsmv2 modify-backup-attributes \
    --backup-id [BACKUP_ID] \
    --never-expires

# Verify backup status
aws cloudhsmv2 describe-backups \
    --filters clusterIds=[CLUSTER_ID]

