FROM jrbeverly/baseimage:alpine-3.5
MAINTAINER jrbeverly

# Build Arguments
#
# Arguments used in the build process of the docker container.
# ..

# Environment Variables
#
# Environment variables present in the docker container.
# ..

# Provision
#
# Copy and execute provisioning scripts of the docker container.
COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

# Volumes
#
# Volumes exposed by the docker container.
VOLUME /media

# Options
#
# Configuration options of the docker container.
WORKDIR /media
ENTRYPOINT []
CMD []

# User Arguments
#
# Arguments used in the user process of the docker container.
ARG USER

# User
#
# Configuration of the docker user for container execution.
USER ${USER}

# Metadata Arguments
#
# Arguments used in the build process of the docker container.
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

# Metadata 
#
# The metadata of the image.
LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="boilerplate" \
    org.label-schema.description="A boilerplate template for docker projects." \
    org.label-schema.url="https://gitlab.com/jrbeverly-docker/docker-boilerplate" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-boilerplate.git" \
    org.label-schema.version=$VERSION