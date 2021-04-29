# Setting color variables to customize the output
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

function text_to_grey () {
  tput setaf 240
}

function error_treatment () {
  if [ $? -ne 0 ]
    then
      echo "${red}ERROR${reset} on ${yellow}$current_action${reset} removal. Already deleted?"
    else
      echo "${green}$current_action deleted...${reset}"
  fi
}

# Remove nginx container
current_action="Nginx container"
echo
echo "Stopping and removing $current_action..."
text_to_grey
docker rm pfa-nginx -f
error_treatment

# Remove MySQL container
current_action="MySQL container"
echo
echo "Stopping and removing $current_action..."
text_to_grey
docker rm pfa-mysql -f
error_treatment

# Remove NodeJS container
current_action="NodeJS container"
echo
echo "Stopping and removing $current_action..."
text_to_grey
docker rm pfa-node -f
error_treatment

# Remove docker network
current_action="Docker network"
echo
echo "Removing network..."
text_to_grey
docker network rm pfa
error_treatment

# Remove images
echo
read -p "Do you want to remove the images created on start.sh? (y/N)" -n 1 -r choice
echo
if [[ $choice =~ ^[Yy]$ ]]
  then
    echo "Removing images..."
    docker image rm dnbtr/pfa-node > /dev/null 2>&1
    docker image rm dnbtr/pfa-mysql > /dev/null 2>&1
    docker image rm dnbtr/pfa-nginx > /dev/null 2>&1
  else
    echo "Images won't be removed."
fi

echo
echo "${green}Done.${reset}"
echo