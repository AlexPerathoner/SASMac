#!/usr/bin/env bash 
# Written by Alexander Perathoner
# 	with the help of
#	~Leon from Mac Support@TUM


# Checking if everything needed on Mac is installed
if ! command -v docker &> /dev/null
then
    echo "Docker could not be found. Please install docker first: https://docs.docker.com/desktop/mac/install/"
    exit
fi

if ! command -v xquartz &> /dev/null
then
    echo "XQuartz could not be found. Installing XQuartz..."
    brew install xquartz
	osascript -e "tell application \"XQuartz\" to activate"
	echo "Please open XQuartz preferences and enable 'Client network connections' in the Security tab. Then log out and back in to finish the installation."
	exit
fi

echo "Getting IP address..."
IP=$(ipconfig getifaddr en0)
echo "Your ip address is: "$IP

echo "Checking if Docker container is not yet present..."
if [ "$(docker ps -q -f name=sasm)" ]
then
	echo "Container already running."
elif [ ! "$(docker ps -aq -f status=exited -f name=sasm)" ]
then
	echo "Creating permament Docker container..."
	docker run -e DISPLAY=$IP:0 -d -i -t -v ~:/Mac --name sasm ubuntu #adding shared filesystem to access documents on mac
	echo "Docker container created. You can now find it in the Docker Desktop app as well."

	echo "Installing necessary packages in the container..."
	docker exec -it sasm apt-get update
	docker exec -it sasm apt-get install -y gcc-multilib \
		gdb nasm libgl1 libqt5gui5 libqt5network5 \
		libqt5core5a libqt5widgets5 libxcb-xinerama0 wget
	echo "Finished installing packages..."

	echo "Downloading SASM..."
	docker exec -it sasm wget http://download.opensuse.org/repositories/home:/Dman95/xUbuntu_20.04/amd64/sasm_3.12.1-1_amd64.deb
	echo "Installing SASM..."
	docker exec -it sasm dpkg -i sasm_3.12.1-1_amd64.deb

	echo "SASM successfully installed."
else
	echo "Docker container SASM found. Starting..."
	docker start sasm
fi

echo "Startin XQuartz..."
# Using applescript to get right path to XQuartz
osascript -e "tell application \"XQuartz\" to activate"
# Adding current ip to access control list 
xhost + $IP

echo "Starting SASM..."
docker exec -it sasm sasm # First sasm is the container's name, second is the command to start sasm



