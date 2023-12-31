#!/system/bin/sh
# Software developed by Trevias Xk
# Social networks: treviasxk
# Github: https://github.com/treviasxk

localbuild="/data/local/tmp/ubuntu"

banner(){
     clear
     echo " ============= UBUNTU TERMUX ROOT ============="
     echo -e "\e[1m\e[32m ______ ___ ___ _ _ . _ ___ _ _ _ _"
     echo " || |__/ |___ \ / | /_\ |__ \/ |/ "
     echo " || | \ |___ \/ | / \ __| _/\_ |\_"
     echo -e "\e[0m\e[39m ______________________________________________"
     echo "SOCIAL MEDIA: treviasxk"
     echo "VERSION: 1.0.4.0"
     echo "LICENSE: GPL-3.0"
     echo " ============================================"
}
banner
echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m PREPARING... \e[0m"

if [ "$EUID" -ne 0 ]
then
     #Tools needed in Termux to install Ubuntu
     pkg up -y -qq
     pkg install tsu -y -qq
     pkg install git -y -qq
     pkg install xz-utils -y -qq
     pkg install wget -y -qq

     #sudo mount -o rw,remount /data 2> /dev/null

     #Checking device architecture
     case `dpkg --print-architecture` in
aarch64)
archurl="arm64" ;;
arms)
archurl="armhf" ;;
amd64)
archurl="amd64" ;;
x86_64)
archurl="amd64" ;;
*)
echo "Unknown architecture"; exit 1;;
esac

     banner
     echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m DOWNLOADING DATA... \e[0m"

     #Downloading files mandatory for proper functioning
     git clone https://github.com/treviasxk/UbuntuTermuxRoot
     cd UbuntuTermuxRoot

     banner
     echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m DOWNLOADING UBUNTU BASE 22.04... \e[0m"

     #Downloading Ubuntu Base 22.04 according to architecture
     wget "https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04-base-$archurl.tar.gz" -O ubuntu-base.tar.gz

     banner
     echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALLING... \e[0m"

     #Creating folders on the system
     sudo mkdir -p $localbuild #Folder for ubuntu installation
     sudo mkdir -p $localbuild/dev #Folder for additional ubuntu resources

     #Extracting ubuntu system in the folder created in the system
     sudo tar -xzf ./ubuntu-base.tar.gz --exclude='dev' -C $localbuild
    
     #Changing file permissions
     chmod 777 ./scripts/ubuntu
     chmod 644 ./scripts/passwd
     chmod 644 ./scripts/resolv.conf
     chmod 644 ./scripts/hosts
     chmod 644 ./scripts/group
     chmod 640 ./scripts/shadow
     chmod 640 ./scripts/gshadow
     chmod 755 ./scripts/adduser

     #Settings necessary for Ubuntu to work
     sudo mv ./scripts/resolv.conf $localbuild/etc #Adding DNS
     sudo mv ./scripts/hosts $localbuild/etc #Adding local domains
     sudo mv ./scripts/group $localbuild/etc #Group permissions
     sudo mv ./scripts/passwd $localbuild/etc #User permissions
     sudo mv ./scripts/shadow $localbuild/etc #Account information security
     sudo mv ./scripts/gshadow $localbuild/etc #Security of group information
     sudo mv ./scripts/adduser $localbuild/sbin #Custom script, to fix internet
     mv ./scripts/ubuntu $PREFIX/bin #Shortcut to start ubuntu

     #Cleaning installation
     rm -rf ../UbuntuTermuxRoot
     rm ../install

     banner
     echo -e "\e[30;48;5;82m STATUS \e[40;38;5;82m INSTALLED SUCCESSFULLY! \e[0m"
     echo "Use the command 'ubuntu' to start the system."
else
     banner
     echo "Installation does not work directly from the root"
fi
