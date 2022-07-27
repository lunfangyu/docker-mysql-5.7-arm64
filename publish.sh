#!/usr/bin/env bash 
docker build -t lunfangyu/mysql-5.7-arm64 ./
docker push lunfangyu/mysql-5.7-arm64:latest
