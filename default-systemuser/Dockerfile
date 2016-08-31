# The default image for spawning notebooks
# Has Pyton, Octave, and Julia

FROM ritjupyter/minimal-systemuser
MAINTAINER Joshua Milas <jgm6496@rit.edu>

USER root

# Install and setup octave
# Install Octave, all of its packages, and gnuplot
# less is needed by gnuplot
RUN apt-get update && apt-get install -yq --no-install-recommends \
    octave \
    octave-* \
    gnuplot \
    less \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install the octave kernel
# It needs the ipywidgets apparently
RUN pip --no-cache-dir install octave_kernel && \
    python -m octave_kernel.install



# Install and setup Julia
RUN apt-get update && apt-get install -yq --no-install-recommends \
    julia \
    libnettle6 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# We need this to install julia packages system wide
RUN mkdir /opt/julia-global-packages && \
    echo 'push!(LOAD_PATH, "/opt/julia-global-packages")' >> /etc/julia/juliarc.jl
ENV JULIA_PKGDIR /opt/julia-global-packages

# Install IJulia, the Julia Jupyter kernel
RUN julia -e 'Pkg.init()'
RUN julia -e 'Pkg.add("IJulia")'
# precompile packages
RUN julia -e 'using BinDeps' && \
    julia -e 'using Compat' && \
    julia -e 'using Conda' && \
    julia -e 'using IJulia' && \
    julia -e 'using JSON' && \
    julia -e 'using Nettle' && \
    julia -e 'using SHA' && \
    julia -e 'using URIParser' && \
    julia -e 'using ZMQ' && \
    julia -e 'Pkg.update()'
RUN chmod -R 777 /opt/julia-global-packages/*



# Install IArm
RUN pip install iarm && \
    python -m iarm_kernel.install
