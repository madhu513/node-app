#!/bin/bash
sed "s/2ea5f10dbe6c56cad3/$1/g" pods.yml > node-app-pod.yml
