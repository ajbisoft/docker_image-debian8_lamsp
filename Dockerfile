FROM ajbisoft/debian9_lapp
MAINTAINER Jakub Kwiatkowski <jakub@ajbisoft.pl>
RUN apt-get update && apt-get install -y php7.1-sybase \
  && apt-get -y --purge autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*
