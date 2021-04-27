# Setting color variables to customize the output
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo
echo "Stopping container..."
docker stop pfa-mysql

if [ $? -ne 0 ]
  then
    echo "${red}Error stopping container. Already stopped?${reset}"
  else
    echo "${green}Container stopped...${reset}"
fi

echo
echo "Removing container..."
docker rm pfa-mysql

if [ $? -ne 0 ]
  then
    echo "${red}Error during container removal. Already deleted?${reset}"
  else
    echo "${green}Container deleted...${reset}"
fi

echo
echo "Removing network..."
docker network rm pfa

if [ $? -ne 0 ]
  then
    echo "${red}Error during container removal. Already deleted?${reset}"
  else
    echo "${green}Network deleted...${reset}"
fi
echo
echo "${green}Done.${reset}"
echo