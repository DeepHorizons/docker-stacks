# Docker file for building the base system user image

FROM ritjupyter/base-systemuser
MAINTAINER Joshua Milas <jgm6496@rit.edu>

USER root

# Install the spell check plugin
RUN jupyter nbextension install https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter nbextension enable calico-spell-check
## Another way as described here https://groups.google.com/forum/#!topic/jupyter/LWGyiOtBZDA
#RUN cd /tmp && \
#    git clone https://github.com/Calysto/notebook-extensions.git && \
#    cd notebook-extensions && \
#    jupyter nbextension install calysto --user

# Add the KGCOE report template and files
# This must be changed if there is an update to python
# `ls -d /opt/conda/lib/python*` will get you the correct location
COPY kgcoe_jupyter_template.tplx /opt/conda/lib/python3.5/site-packages/nbconvert/templates/latex/article.tplx
COPY KGCOEReport.cls /usr/local/share/texmf/tex/latex/KGCOEReport.cls
RUN texhash /usr/local/share/texmf
