#!/bin/bash

cd ./vagrant-config/gitlab-server/
vagrant destroy -f
cd ./vagrant-config/gitlab-server/
cd ../runner-server/lab/
vagrant destroy -f
