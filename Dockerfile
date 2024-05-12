FROM public.ecr.aws/amazonlinux/amazonlinux:latest

# Install required dependencies
RUN yum update -y && \
    yum install -y jq unzip

# Install MinIO client
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
    --create-dirs \
    -o $HOME/minio-binaries/mc && chmod +x $HOME/minio-binaries/mc && \
    export PATH=$PATH:$HOME/minio-binaries/

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

COPY replication.yaml ./replication.yaml
COPY create_replication_task.sh ./create_replication_task.sh
RUN chmod +x ./create_replication_task.sh

ENTRYPOINT ./create_replication_task.sh
