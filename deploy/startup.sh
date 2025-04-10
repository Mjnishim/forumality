#!/bin/bash

minikube image build . -t forumality-dev:latest

cd deploy

kubectl apply -k overlays/dev