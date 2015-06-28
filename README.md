# Falcon-Tomcat
Docker repo for a Falcon Tomcat-based container.

# Usage
This Dockerfile with all default values will build a base container running Apache Tomcat version 8.0.20 with OpenJDK 8u40.

## Building
`docker build [--rm=true] [--tag=<your-tag>] [--file=<relative-path-to-this-Dockerfile>]`
  when --file is not specified, it defaults to ./Dockerfile in the current directory.

example:  `docker build --rm=true --tag=falcon-tomcat:8.0.20 .`
this builds the container with the specified tag using the current directory Dockerfile file.

## Running the built image
The following environment variables are exposed (default values indicated):

* TOMCAT_MAJOR (8)
* TOMCAT_VERSION (8.0.20)
* TOMCAT\_DL\_URL (see Dockerfile)
* CATALINA_HOME (/usr/local/tomcat)
* PATH ($CATALINA_HOME/bin:$PATH)
* TOMCAT_ENV (`local` if not specified). This value is used in the setenv.sh file (passed as `-Denv`)



## Current limitations
1. Does not add the 'admin-gui' or 'admin-script' role to use the "Host Manager" feature.
2. Has a hard-coded username and password for the manager app.
3. Configured for HTTP not HTTPS with no automated way to change it in the Dockerfile.

