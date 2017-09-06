FROM ajbisoft/debian9_lapp
MAINTAINER Jakub Kwiatkowski <jakub@ajbisoft.pl>
RUN apt-get update && apt-get install -y unixodbc libgss3 odbcinst libssl-dev \
  && apt-get -y --purge autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY 20-pdo_sqlsrv.ini /etc/php/7.1/apache2/conf.d/
COPY pdo_sqlsrv.so /usr/lib/php/20160303/
COPY odbcinst.ini /etc/
COPY libmsodbcsql-13.0.so.0.0 /usr/local/lib/
