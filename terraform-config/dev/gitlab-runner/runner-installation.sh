#! /bin/bash

echo 1 | sudo -S cp -rf /tmp/gitlab-runner/hosts /etc/
echo 1 | sudo -S apt-get update -y
echo 1 | sudo -S curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | echo 1 | sudo bash
echo 1 | sudo -S apt-get install -y gitlab-runner
echo 1 | sudo -S apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
echo 1 | sudo -S apt-get update -y
echo 1 | sudo -S chmod +x /usr/local/bin/docker-compose
echo 1 | sudo -S apt-cache madison gitlab-runner -y
echo 1 | sudo -S gitlab-runner -version
echo 1 | sudo -S usermod -aG docker gitlab-runner
echo 1 | sudo -S usermod -aG sudo gitlab-runner
cat >> /etc/sudoers <<< 'gitlab-runner ALL=(ALL) NOPASSWD: ALL'
echo 1 | sudo -S mkdir -p /home/docker-app/registry && chmod -R 777 /home/docker-app/registry && cd /home/docker-app/registry
echo 1 | sudo -S mkdir certs data
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/runner-ssl/rootCA.crt /home/docker-app/registry/certs/
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/runner-ssl/rootCA.key /home/docker-app/registry/certs/
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/runner-ssl/registry.enigma.com.vn.csr /home/docker-app/registry/certs/
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/runner-ssl/registry.enigma.com.vn.crt /home/docker-app/registry/certs/
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/runner-ssl/registry.enigma.com.vn.key /home/docker-app/registry/certs/
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/runner-ssl/registry.enigma.com.vn.ext /home/docker-app/registry/certs/
echo 1 | sudo -S cp -rf /tmp/gitlab-runner/docker-compose.yml /home/docker-app/registry/
cd /home/docker-app/registry/ && echo 1 | sudo -S docker compose up -d
echo 1 | sudo -S cp -rf /home/docker-app/registry/certs/rootCA.crt /usr/local/share/ca-certificates/
echo 1 | sudo -S update-ca-certificates
echo 1 | sudo -S gitlab-runner register --non-interactive --url="https://gitlab.enigma.com.vn" --registration-token="GR1348941oEzsPCmVWLGo4gQxCdE-" --executor="shell"
echo 1 | sudo -S mkdir -p /etc/docker/certs.d/registry.enigma.com.vn/
echo 1 | sudo -S cp -rf /home/docker-app/registry/certs/registry.enigma.com.vn.crt /etc/docker/certs.d/registry.enigma.com.vn/registry.enigma.com.vn.crt
echo 1 | sudo -S systemctl restart docker