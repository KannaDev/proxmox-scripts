# Proxmox Scripts

Generally these are scripts that *should* be able to be used with anything using QEMU, and any host by removing the "qemu-guest-agent", with the whole purpose me being lazy and wanting something that doesn't rely on templates and cloud-init (I do use them but sometimes they do not meet my requirements, and might use ansible)

## vm-init.sh

This script has the purpose of being used for updating a system that has just booted, installing some basic packages such as Docker. and then asking for the API keys for services which I use. While it may be pointless running both NewRelic and DataDog, it's what works for me.
