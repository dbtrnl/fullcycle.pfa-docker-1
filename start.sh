# Setting color variables to customize the output
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo
echo "Creating network named 'pfa'..."
docker network create pfa

# Error treatment
if [ $? -ne 0 ]
  then
    echo "${red}Error during network creation. Exiting...${reset}"
    echo
    exit 1
  else
    echo "${green}Network created!${reset}"
fi

echo
echo "Creating database container..."
docker run --name pfa-mysql -h 127.0.0.1 -p 3306 --network=pfa -e MYSQL_ROOT_PASSWORD=mysql -d mysql

# Error treatment
if [ $? -ne 0 ]
  then
    echo "${red}Error during container creation. Exiting...${reset}"
    echo
    exit 1
  else
    echo "${green}Container created!${reset}"
fi

echo
echo "Waiting until database is ready..."
sleep 15
# Wait until the Database is started inside the container
# The output messages are supressed.
until docker exec -i pfa-mysql mysql -uroot -pmysql -e "show databases" > /dev/null 2>&1
do
  echo "Database not yet ready. Waiting 5 secs to try again..."
  sleep 5
done

# Populate the database
echo
echo "Populating the database..."
docker exec -i pfa-mysql mysql -pmysql < ./mysql/db-setup.sql > /dev/null 2>&1
if [ $? -ne 0 ]
  then
    echo "${red}Error while populating the database. Exiting...${reset}"
    echo
    exit 1
  else
    echo "${green}Database sucessfully populated!${reset}"
fi

# Querying the database and supressing warning message...
echo
echo "Querying data on the database..."
echo "SELECT COUNT(*) FROM fc_modules;"
docker exec -i pfa-mysql mysql -uroot -pmysql -e "use fc; select count(*) from fc_modules;" 2>&1 | grep -v "Warning"

echo
if [ $? -ne 0 ]
  then
    echo "${red}Error making the query. Exiting...${reset}"
    echo
    exit 1
  else
    echo "${green}Done.${reset}"
    echo
fi