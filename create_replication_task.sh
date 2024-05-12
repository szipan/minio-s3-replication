#!/bin/bash

sed -i -e "s/{src_bucket}/$MINIO_SRC_BUCKET/g" -e "s/{dest_bucket}/$S3_DEST_BUCKET/g" -e "s/{ak}/$AWS_ACCESS_KEY_ID/g" -e "s/{sk}/$AWS_SECRET_ACCESS_KEY/g" ./replication.yaml

$HOME/minio-binaries/mc alias set $MINIO_ALIAS $MINIO_ENDPOINT $MINIO_AK $MINIO_SK

$HOME/minio-binaries/mc batch start $MINIO_ALIAS/ ./replication.yaml
