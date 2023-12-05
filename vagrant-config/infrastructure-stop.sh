#!/bin/bash

cd ./vagrant-config/gitlab-server/
vagrant halt
cd ./vagrant-config/gitlab-server/
cd ../runner-server/
vagrant halt
