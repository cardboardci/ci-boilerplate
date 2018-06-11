FROM jrbeverly/baseimage:ubuntu

#
# Provision
#
COPY rootfs/ /

COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

# Provision
#
# Copy and execute provisioning scripts of the docker container.
COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

# 
# Options
# 
WORKDIR /media
ENTRYPOINT []
CMD []

#
# User
#
ARG USER
USER $USER

#
# Metadata Arguments
#
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

#
# Metadata
#
LABEL \
    maintainer="jrbeverly" \
    \
    org.label-schema.name="boilerplate" \
    org.label-schema.summary="A boilerplate image showing the structure of a project." \
    org.label-schema.description="Summary of an image." \
    org.label-schema.maintainer="jrbeverly" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.url="https://www.docker.com/" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-boilerplate" \
    org.label-schema.docker.cmd="ddocker run hello-world" \
    \
    io.jrbeverly.project="boilerplate" \
    io.jrbeverly.summary="A docker image with boilerplate, running as the $USER user." \
    io.jrbeverly.boilerplate.meta.BUILD_DATE="The Date/Time the image was built." \
    io.jrbeverly.boilerplate.meta.VERSION="Release identifier for the contents of the image." \
    io.jrbeverly.boilerplate.meta.VCS_REF="Identifier for the version of the source code from which this image was built." \
    io.jrbeverly.boilerplate.args.USER="Sets the [user](http://www.linfo.org/uid.html) to use when running the image." \
    io.jrbeverly.boilerplate.volume.media="/media/|The default working directory of the image."
