FROM centos:7
RUN yum clean all && yum install -y createrepo
WORKDIR /simplerepo
CMD createrepo .
