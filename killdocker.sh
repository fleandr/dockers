#!/bin/bash
docker stop master
docker stop slave01
docker stop slave02
docker rm master
docker rm slave01
docker rm slave02
