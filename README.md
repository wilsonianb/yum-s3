# Yum S3

Docker image for deploying rpm(s) to yum repository on AWS S3.

Docker container deploys all files in the specified local directory to specifed S3 directory.

## Dependencies

- [docker](https://docs.docker.com/install/)

## Configuration

All configuration is performed via environment variables:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- S3_DIR: target S3 directory with yum repository

## Build

```
docker build -t yum-s3 .
```

## Run

```
docker run --rm -v <path-to-rpm-dir>:/s3-rpms -e S3_DIR=<target-s3-dir> -e AWS_ACCESS_KEY_ID=<key-id> -e AWS_SECRET_ACCESS_KEY=<key> yum-s3
```
