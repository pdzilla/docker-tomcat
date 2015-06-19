# falcon-tomcat
Docker repo for a falcon-based tomcat container.

# Usage
This Dockerfile will build a base container running Apache Tomcat version 8.0.20 with OpenJDK 8u40.

## Building
`docker build [--rm=true] [--tag=<your-tag>] [--file=<relative-path-to-this-Dockerfile>] ./path`
  when --file is not specified, it defaults to ./Dockerfile in the current directory.

example:  `docker build --rm=true --tag=falcon-tomcat:8.0.20 .`
this builds the container with the specified tag using the current directory Dockerfile file.

## Current limitations
1. Does not provide a user and role for access to /manager.
2. If a setenv is needed, it must be added.
