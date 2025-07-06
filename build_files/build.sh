#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#
# install extensions
dnf5 install -y python3-pip
pip3 install --upgrade gnome-extensions-cli

gext -F install 307 615 7065
gext enable 307 615 7065

# setup docker
dnf install -y dnf-plugins-core
dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

wget https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm

dnf install ./docker-desktop-x86_64.rpm


# setup micrsoft software
wget https://packages.microsoft.com/keys/microsoft.asc
mv microsoft.asc /etc/pki/rpm-gpg
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf install -y azure-cli code 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
