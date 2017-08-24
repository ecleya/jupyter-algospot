# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/minimal-notebook

MAINTAINER ecleya <ecleya@gmail.com>


# Install Algospot Kernel
RUN conda update conda && \
    conda create -y --name algospot python=3.4.3 ipykernel && \
    /bin/bash -c "source activate algospot" && \
    pip install requests termcolor beautifulsoup4 && \
    python -m ipykernel install --user --name "algospot" && \
    /bin/bash -c "source deactivate"

ADD algospot_utils.ipynb /home/jovyan/algospot_utils.ipynb
