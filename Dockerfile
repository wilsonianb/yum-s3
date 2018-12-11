FROM centos:7

RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y createrepo python-pip
RUN pip install awscli

COPY update-s3.sh ./

CMD SOURCE_DIR=/s3-rpms ./update-s3.sh
