#!/bin/bash

cd ./vagrant-config/gitlab-server/
vagrant up
cd ./vagrant-config/gitlab-server/
cd ../runner-server/lab/
vagrant up
