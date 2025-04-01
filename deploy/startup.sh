#!/bin/bash

docker build . -t forumality-dev:latest
# Still gotta see if I can do better with this, gah
minikube image load forumality-dev:latest

cd deploy

kubectl apply -k overlays/dev