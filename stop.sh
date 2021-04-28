# Setting color variables to customize the output
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo
echo "Stopping and removing Nginx container..."
docker rm pfa-nginx -f

if [ $? -ne 0 ]
  then
    echo "${red}Error during container removal. Already deleted?${reset}"
  else
    echo "${green}Nginx container deleted...${reset}"
fi

echo
echo "Stopping and removing MySQL container..."
docker rm pfa-mysql -f

if [ $? -ne 0 ]
  then
    echo "${red}Error during container removal. Already deleted?${reset}"
  else
    echo "${green}MySQL container deleted...${reset}"
fi

echo
echo "Stopping and removing NodeJS container..."
docker rm pfa-node -f

if [ $? -ne 0 ]
  then
    echo "${red}Error during container removal. Already deleted?${reset}"
  else
    echo "${green}NodeJS container deleted...${reset}"
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