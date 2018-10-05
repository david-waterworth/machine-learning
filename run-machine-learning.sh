#!/bin/bash
docker run --runtime=nvidia --rm -p 8888:8888 -v "$HOME"/machine-learning/notebooks:/home/david-waterworth/notebooks david-waterworth/machine-learning:latest --name machine-learning