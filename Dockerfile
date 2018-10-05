# based on https://github.com/jupyter/docker-stacks and https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/docker 

# use base image from https://hub.docker.com/r/nvidia/cuda/

# requires https://github.com/NVIDIA/nvidia-docker and https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

USER root

# Configure environment
ENV SHELL=/bin/bash \
    USER=david-waterworth \
    UID=1000 \
    GID=100

# copy support script
ADD fix_permissions /usr/local/bin/fix-permissions

# Create user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN groupadd wheel -g 11 && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    useradd -m -s /bin/bash -N -u $UID $USER && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME

USER $UID

# Setup notebooks directory for backward-compatibility
RUN mkdir /home/$USER/notebooks && \
    fix-permissions /home/$USER

USER root

# install tools and libs
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python3-pip \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# upgrade pip
RUN pip3 install --upgrade pip

# install setuptools
RUN pip3 --no-cache-dir install \
        setuptools

# install packages
RUN pip3 --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        keras_applications \
        keras_preprocessing \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        && \
    python3 -m ipykernel.kernelspec

# install tensorflow
RUN pip3 --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.11.0-cp35-cp35m-linux_x86_64.whl

# IPython
EXPOSE 8888

WORKDIR /home/$USER/notebooks

# Configure container startup
CMD ["jupyter", "notebook"]

# Add local files as late as possible to avoid cache busting
COPY jupyter_notebook_config.py /etc/jupyter/
RUN fix-permissions /etc/jupyter/

# Switch back to david-waterworth to avoid accidental container runs as root
USER $UID