### Install OpenTofu
```shell
# Download the installer script:
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
# Alternatively: wget --secure-protocol=TLSv1_2 --https-only https://get.opentofu.org/install-opentofu.sh -O nstall-opentofu.sh

# Give it execution permissions:
chmod +x install-opentofu.sh

# Please inspect the downloaded script

# Run the installer:
./install-opentofu.sh --install-method rpm

# Remove the installer:
rm -f install-opentofu.sh
```

### Download Fedora KVM image on each node
```shell
mkdir /var/lib/vz/template/qcow || \
cd /var/lib/vz/template/qcow && \
wget https://download.fedoraproject.org/pub/fedora/linux/releases/40/Server/x86_64/images/Fedora-Server-KVM-40-1.14.x86_64.qcow2
```

### Creating the Proxmox user and role for OpenTofu
[Proxmox Provider](https://library.tf/providers/Telmate/proxmox/latest)
```shell
# Create the user
sudo pveum user add terraform@pve
# Create a role for the user above
sudo pveum role add Terraform -privs "Datastore.Allocate Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify SDN.Use VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt User.Modify"
# Assign the terraform user to the above role
sudo pveum aclmod / -user terraform@pve -role Terraform
# Create the token
sudo pveum user token add terraform@pve provider --privsep=0
```

### Using OpenTofu
```shell
tofu init
tofu plan -out plan
tofu apply "plan"
```