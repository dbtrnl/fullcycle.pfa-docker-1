# Setting color variables to customize the output
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

echo "${green}Removing preexisting images...${reset}"
docker image rm dnbtr/pfa-node > /dev/null 2>&1
docker image rm dnbtr/pfa-mysql > /dev/null 2>&1
docker image rm dnbtr/pfa-nginx > /dev/null 2>&1

echo
echo "${green}Building ${yellow}'pfa-node'${green} image..."
docker build -t dnbtr/pfa-node ./node > /dev/null 2>&1
echo
echo "Building ${yellow}'pfa-mysql'${green} image..."
docker build -t dnbtr/pfa-mysql ./mysql > /dev/null 2>&1
echo
echo "Building ${yellow}'pfa-nginx'${green} image..."
docker build -t dnbtr/pfa-nginx ./nginx > /dev/null 2>&1
echo
echo "Done.${reset}"