#!/bin/bash
docker stop master2
docker stop sslave01
docker stop sslave02
docker rm master2
docker rm sslave01
docker rm sslave02
