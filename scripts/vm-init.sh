#! /bin/bash

# Updating System
sudo apt-get update && sudo apt-get dist-upgrade -y

# Installing base packages

sudo apt-get install qemu-guest-agent git dbus-user-session fail2ban -y 

# Start qemu-guest-agent

sudo systemctl enable qemu-guest-agent && sudo systemctl start qemu-guest-agent

# Request API Keys

read -p 'DataDog API Key: ' datadogapikey
read -p 'DataDog Site (without https://): ' datadogapisite
read -p 'NewRelic Key: ' newrelicapikey
read -p 'NewRelic Account ID: ' newrelicaccountid
read -p 'NewRelic Account Region: ' newrelicaccountregion
# The above will be changed as to how it functions so you're always not inputting it for multiple VM's, as currently you need to add it for each time you run the script.

# Install Docker (from https://docs.docker.com/engine/install/ubuntu/)
# Add Docker's official GPG key:

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Rootless Docker

dockerd-rootless-setuptool.sh install

# Install Tailscale

curl -fsSL https://tailscale.com/install.sh | sh

# Install NewRelic
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY=${newrelicapikey} NEW_RELIC_ACCOUNT_ID=${newrelicaccountid} NEW_RELIC_REGION=${newrelicaccountregion} /usr/local/bin/newrelic install -y

# Install DataDog
DD_API_KEY=${datadogapikey} DD_SITE=${datadogapisite} DD_APM_INSTRUMENTATION_ENABLED=host bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

# Implement fail2ban wip

# End of implementation
