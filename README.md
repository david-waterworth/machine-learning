# machine-learning

Requires Ubuntu 18.04

install cuda-10

https://www.pugetsystems.com/labs/hpc/How-To-Install-CUDA-10-together-with-9-2-on-Ubuntu-18-04-with-support-for-NVIDIA-20XX-Turing-GPUs-1236/

install docker-ce

https://docs.docker.com/install/linux/docker-ce/ubuntu/

install nvidia-docker2

https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0)

build

$ sudo docker build -f ./docker/Dockerfile -t david-waterworth/machine-learning:latest  ./docker

run

$ sudo docker run -it --runtime=nvidia --rm -p 8888:8888 -v "$HOME"/machine-learning/notebooks:/home/mluser/notebooks --name machine-learning david-waterworth/machine-learning:latest