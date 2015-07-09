[![](https://badge.imagelayers.io/pdzilla/tomcat:latest.svg)](https://imagelayers.io/?images=pdzilla/tomcat:latest 'Get your own badge on imagelayers.io')

# Docker-Tomcat
Docker repo for a Tomcat-based container. This Dockerfile has no external files to copy or add, so it can be used as a standalone file to get up and running.

# Usage
This Dockerfile with all default values will build a base container image running Apache Tomcat version 8.0.20 with OpenJDK 8u40.

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
* MANAGER_USER (admin)
* MANAGER_PW (password)

Examples:
All defaults:
`docker run -d -p 8080:8080 pdzilla/tomcat`

Defaults with different environment:
`docker run -d -p 8080:8080 -e "TOMCAT_ENV=<new_env_name>" --name tomcat pdzilla/tomcat`

## Current limitations
1. Does not add the 'admin-script' role to use the "Host Manager" feature.
2. Configured for HTTP not HTTPS with no automated way to change it in the Dockerfile. Users should add their own SSL/TLS solution on top of this base image and `docker commit` it.
3. Tomcat JVM memory settings not currently configurable (512 min 1024 max)
4. You need to re-build to change the `MANAGER_USER` and `MANAGER_PW` values. I'll fix that when I can, or submit a PR and I'll review it.

## Contributing
Want to contribute to this? I'm both humbled and honestly a little surprised. PRs and issues are welcome.  Please verify against Docker 1.7 before committing
