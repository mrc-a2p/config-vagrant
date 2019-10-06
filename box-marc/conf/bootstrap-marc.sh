
# Using single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='12345678'
PROJECTFOLDER='public'

# create project folder
sudo mkdir "/var/www/${PROJECTFOLDER}"

# update / upgrade
echo "Updating apt-get..."
sudo apt-get update
sudo apt-get -y upgrade
sudo -s
