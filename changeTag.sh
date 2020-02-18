#!/bin/bash
sed "$/tagVersion/$1/g" pods.yml > node-app-pod.yml
