# Install git
sudo apt-get install git -y

# Clone Anthony fork / update this once merged
sudo git clone https://github.com/anthonychu/TailwindTraders-Website.git /tailwind
cd /tailwind
sudo git checkout monolith

# Install dotenet 2.2
sudo wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-2.2=2.2.102-1 -y

# Install node / npn
sudo apt install nodejs -y
sudo apt install npm -y

# Install NGINX and config reverse proxy
sudo apt-get install nginx -y
sudo service nginx start
sudo rm /etc/nginx/sites-available/default
sudo wget https://raw.githubusercontent.com/neilpeterson/tailwind-reference-deployment/master/deployment-artifacts-standalone-vm/default -O /etc/nginx/sites-available/default
sudo nginx -t
sudo nginx -s reload

# Publish application
cd /tailwind/Source/Tailwind.Traders.Web
sudo dotnet publish -c Release -o /tailwind

# Config application auto-start
sudo apt-get install -y supervisor
sudo touch /etc/supervisor/conf.d/tailwind.conf
sudo wget https://raw.githubusercontent.com/neilpeterson/tailwind-reference-deployment/master/deployment-artifacts-standalone-vm/tailwind.conf -O /etc/supervisor/conf.d/tailwind.conf
sudo sed -i "s/<replacesql>/$1/g" /etc/supervisor/conf.d/tailwind.conf
sudo sed -i "s/<replaceuser>/$2/g" /etc/supervisor/conf.d/tailwind.conf
sudo sed -i "s/<replacepassword>/$3/g" /etc/supervisor/conf.d/tailwind.conf
sudo sed -i "s/<replacecosmos>/$4/g" /etc/supervisor/conf.d/tailwind.conf
sudo sed -i "s/<replacecosmoskey>/$5/g" /etc/supervisor/conf.d/tailwind.conf
sudo service supervisor stop
sudo service supervisor start