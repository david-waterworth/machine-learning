FROM jupyter/datascience-notebook:1145fb1198b2

USER root

# add tensorflow-gpu support (requires nvidia runtime (nvidia-docker2), and cuda 10 installed on host )
RUN conda install --quiet --yes \
    'tensorflow-gpu' \
    'keras' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# add sklearn-pandas 1.7.0
RUN git clone --branch 1.1.0 https://github.com/scikit-learn-contrib/sklearn-pandas.git && \
    cd sklearn-pandas && \
    git checkout ab3a73143b5c7441f0e60c4b96f9c78faa295419 && \
    python setup.py install && \
    cd ~ && \
    rm -r sklearn-pandas

USER $UID