FROM ubuntu:19.10

# Install common Dojo scripts
ENV DOJO_VERSION=0.4.3
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  sudo git ca-certificates wget tar nano && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/ai-traders/dojo.git /tmp/dojo_git &&\
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

ENV SCILAB_VERSION=6.0.2
// scilab-doc package is needed for help and demos in scilab
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  scilab=${SCILAB_VERSION}-0ubuntu2 scilab-doc=${SCILAB_VERSION}-0ubuntu2 &&\
  apt-get -y autoremove &&\
  apt-get -y autoclean &&\
  apt-get -y clean &&\
  rm -rf /tmp/* /var/tmp/* &&\
  rm -rf /var/lib/apt/lists/*

# For Bash
COPY profile /home/dojo/.profile
COPY bashrc /home/dojo/.bashrc
RUN chown dojo:dojo -R /home/dojo
RUN echo 'dojo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]

# Problem: scilab 6.0.2 throws this error when drawing a plot and all the plots
# are just empty windows:
# Caused by: com.jogamp.opengl.GLException: Profile GL3bc is not available on X11GraphicsDevice[type .x11, connection unix:0.0, unitID 0, handle 0x7f2bc492fb50, owner true, ResourceToolkitLock[obj 0xa6ebdce, isOwner true, <61dec4c2, 37b535c6>[count 1, qsz 0, owner <AWT-EventQueue-0>]]], but: [GLProfile[GL2ES2/GL3.sw], GLProfile[GL3/GL3.sw], GLProfile[GL3/GL3.sw], GLProfile[GL2GL3/GL3.sw]]
# 	at com.jogamp.opengl.GLProfile.get(GLProfile.java:991)
# 	at jogamp.opengl.GLContextImpl.verifyInstance(GLContextImpl.java:1471)
# Solution: install previous libjogl2-java,
# Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1650958
#
# add apt key for debian sources: https://unix.stackexchange.com/a/452067
RUN apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends  debian-archive-keyring &&\
  sudo ln -s /usr/share/keyrings/debian-archive*.gpg /etc/apt/trusted.gpg.d/ &&\
  echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list.d/libjogl2-java.list &&\
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --allow-downgrades \
  libjogl2-java=2.3.2+dfsg-5
