# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/minimal-notebook

LABEL maintainer="ecleya <ecleya@gmail.com>"


# Install Algospot Kernel
RUN conda update conda && \
    conda create -y --name algospot_py3 python=3.4.3 ipykernel && \
    /bin/bash -c "source activate algospot_py3" && \
    pip install requests termcolor beautifulsoup4 && \
    python -m ipykernel install --user --name "algospot_py3" && \
    /bin/bash -c "source deactivate"

# Install Cling Kernel
USER root
WORKDIR /opt
RUN wget https://root.cern.ch/download/cling/cling_2017-11-13_ubuntu16.tar.bz2 && \
    tar xvf cling_2017-11-13_ubuntu16.tar.bz2 && \
    mv cling_2017-11-13_ubuntu16 cling && \
    rm cling_2017-11-13_ubuntu16.tar.bz2 && \
    chown -R jovyan:users cling && \
    cd /opt/cling/share/cling/Jupyter/kernel && \
    pip install -e . && \
    jupyter-kernelspec install --user cling-cpp11

ENV PATH=/opt/cling/bin:$PATH

WORKDIR $HOME
USER $NB_USER

ADD algospot_utils.ipynb /home/jovyan/algospot_utils.ipynb
