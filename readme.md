# Ubuntu Termux Root
Install Ubuntu Base 22.04 to the root of your smartphone with termux. To start the system, use the `ubuntu` command.

## NOTICE!
Install it yourself, I will not be responsible for any damage that may happen to your device.
## Requirements
• Magisk

• Arm64, armhf, amd64 or x86_64 architecture
## Installation
Enter the shell command below in Termux to install.
```bash
curl -s -L https://raw.githubusercontent.com/treviasxk/UbuntuTermuxRoot/master/install.sh -o install && bash install
```
## Uninstallation
First stop all services and exit Ubuntu with the `exit` command, then close Termux, then enter the shell command below in Termux to be able to uninstall. If you can't, restart your smartphone and start the code again.
```bash
ubuntu -u
```
Or
```bash
ubuntu --uninstall
```
### Problem with apt upgrade
If you are unable to do `apt upgrade`, this problem happens because Ubuntu does not recognize the kernel version correctly in libc6, use the command below to "maneuver" this problem.
```bash
apt-mark hold libc6
```
