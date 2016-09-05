# Docker image: debian8_lamspp

## Description

Official Debian 8 (debian:8) + apache2 + php5 + postgresql-client + php5-mssql docker image with some customization:
* mod_rewrite apache2 module enabled
* DocumentRoot set to /var/www/public
* /etc/apt/sources.list modified to include jessie-updates and to use Polish mirror by default
* WORKDIR set to /var/www/
* ENTRYPOINT set to autostart apache2 service

## Usage

There are two main run-time settings that need to be passed to newly created container from this image:
* There is no EXPOSE statement in Dockerfile, so port must be exposed when starting container by adding `-p 80:80` to your `docker run` statement
* There is no VOLUME statement in Dockerfile, so data volume must be attached when starting container by adding `-v <path_to_your_datadir>:/var/www/` to your `docker run` statement

## Example

To successfully start a new container using this image please specify port (here port 80) and volume options as in following example:
`docker run -dp 80:80 -v <path_to_your_datadir>:/var/www/ --name <your-app-name> ajbisoft/debian8-lap`

## Summary

This docker image is best suited for PHP applications that depend on PostgreSQL AND MSSQL database backends. It works well not only with simple PHP websites, but also with ie. Laravel framework (just mount your project under /var/www).

Should you need to use a different database backend (like MySQL, or PostgreSQL only) with your project, please see my other docker images!
