EFS_MOUNT_DIR="/root/foldername"
S3_BUCKET_NAME="s3://bucketname"

echo"---sync cycle strated---"
/user/bin/aws s3 sync"$EFS_MOUNT_DIR" "$S3_BUCKET_NAME"
echo"---sync cycle completed sucessfully---"