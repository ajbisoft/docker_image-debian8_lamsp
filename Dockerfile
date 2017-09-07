FROM ajbisoft/debian9_lapp
MAINTAINER Jakub Kwiatkowski <jakub@ajbisoft.pl>
COPY odbc_config /usr/local/bin/
COPY msodbcsql-13.0.0.0.tar.gz /usr/local/src/
RUN apt-get update && apt-get install -y unixodbc libgss3 odbcinst libssl-dev \
  && apt-get -y --purge autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && cd /usr/local/src/ && tar -xf msodbcsql-13.0.0.0.tar.gz && cd msodbcsql-13.0.0.0 && ldd lib64/libmsodbcsql-13.0.so.0.0 \
  && printf '#!/bin/bash\n[ "$*" == "-p" ] && echo "x86_64" || /bin/uname "$@"' > /usr/local/bin/uname && chmod +x /usr/local/bin/uname \
  && ./install.sh install --accept-license && odbcinst -q -d -n "ODBC Driver 13 for SQL Server"
COPY 20-pdo_sqlsrv.ini /etc/php/7.1/apache2/conf.d/
COPY pdo_sqlsrv.so /usr/lib/php/20160303/
