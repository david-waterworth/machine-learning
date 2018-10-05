# machine-learning

To build
sudo docker build -f Dockerfile -t david-waterworth/machine-learning:latest  .

To run
sudo docker run --runtime=nvidia --rm -p 8888:8888 -v "$HOME"/machine-learning/notebooks:/home/david-waterworth/notebooks david-waterworth/machine-learning:latest --name machine-learning