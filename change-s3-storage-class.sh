#!/bin/bash

BUCKET_NAME="change-storage-class"
PROFILE="fujita"
STORAGE_CLASS_NAME="ONEZONE_IA" # デフォルトのストレージクラスは STANDARD

echo 'before'
echo $(aws s3api list-objects --bucket change-storage-class --query 'Contents[].{Key: Key, StorageClass: StorageClass}' --profile fujita)

for key in $(aws s3api list-objects --bucket $BUCKET_NAME --query 'Contents[].Key' --output text --profile $PROFILE)
do
  aws s3api copy-object --bucket $BUCKET_NAME --copy-source "${BUCKET_NAME}/${key}" --key "$key" --storage-class $STORAGE_CLASS_NAME --profile $PROFILE > /dev/null
done

echo 'after'
echo $(aws s3api list-objects --bucket change-storage-class --query 'Contents[].{Key: Key, StorageClass: StorageClass}' --profile fujita)
