FROM ajbisoft/debian9_lapp
MAINTAINER Jakub Kwiatkowski <jakub@ajbisoft.pl>

ARG MSODBC_NAME=msodbcsql-13.0.0.0
ARG LIBSSL_DEB=libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb

COPY $MSODBC_NAME.tar.gz /usr/local/src/
COPY odbc_config /usr/local/bin/
ADD http://ftp.us.debian.org/debian/pool/main/o/openssl/$LIBSSL_DEB /usr/local/src/

RUN apt-get update && apt-get install -y unixodbc odbcinst unixodbc-dev php7.2-odbc libgss3 php7.2-dev php-pear \
  && cd /usr/local/src/ && tar -xf $MSODBC_NAME.tar.gz && cd $MSODBC_NAME && ldd lib64/libmsodbcsql-13.0.so.0.0 \
  && printf '#!/bin/bash\n[ "$*" == "-p" ] && echo "x86_64" || /bin/uname "$@"' > /usr/local/bin/uname && chmod +x /usr/local/bin/uname \
  && sed -i.bak 's/req_dm_ver="2.3.1";/req_dm_ver="2.3.4";/' install.sh \
  && ./install.sh install --accept-license && odbcinst -q -d -n "ODBC Driver 13 for SQL Server" && dpkg -i /usr/local/src/$LIBSSL_DEB && rm -rf /usr/local/src/* /tmp/* \
  && pecl channel-update pecl.php.net && pecl install pdo_sqlsrv-4.1.6.1 \
  && printf "; priority=20\nextension=/usr/lib/php/20170718/pdo_sqlsrv.so" > /etc/php/7.2/mods-available/pdo_sqlsrv.ini && ln -s /etc/php/7.2/mods-available/pdo_sqlsrv.ini /etc/php/7.2/apache2/conf.d/20-pdo_sqlsrv.ini \
  && apt-get -y --purge remove unixodbc-dev php7.2-dev php-pear && apt-get -y --purge autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

