# Docker file for building the smallest possible system user

FROM ritjupyter/minimal-notebook
MAINTAINER Joshua Milas <jgm6496@rit.edu>

EXPOSE 8888

USER root
WORKDIR /home
# Delete the current user and its homedir
RUN userdel jovyan && rm -rf /home/jovyan
ENV SHELL /bin/bash

# Get the single-user script
RUN wget -q https://raw.githubusercontent.com/jupyterhub/jupyterhub/0.6.1/scripts/jupyterhub-singleuser -O /usr/local/bin/jupyterhub-singleuser && \
    chmod 755 /usr/local/bin/jupyterhub-singleuser

# Get the systemuser script
RUN mkdir /srv/singleuser/
RUN wget -q https://raw.githubusercontent.com/jupyterhub/dockerspawner/master/systemuser/systemuser.sh -O /srv/singleuser/systemuser.sh && \
    chmod 755 /srv/singleuser/systemuser.sh

# smoke test entrypoint
RUN USER_ID=65000 USER=systemusertest sh /srv/singleuser/systemuser.sh -h && userdel systemusertest

CMD ["sh", "/srv/singleuser/systemuser.sh"]
