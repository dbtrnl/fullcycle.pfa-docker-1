# Setting color variables to customize the output
red=`tput setaf 9`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

function text_to_grey () {
  tput setaf 240
}

function error_treatment () {
  if [ $? -ne 0 ]
    then
      echo "${red}ERROR${reset} on $current_action${reset}. Exiting..."
      echo
      exit 1
    else
      echo "${reset}$current_action...${green} SUCCESS${reset}"
  fi
}

function countdown_fifteen () {
  for count in $(seq 0 15);
  do
    echo -ne "$count seconds\033[0K\r"
    sleep 1
  done
}

function countdown_five () {
  for count in $(seq 0 5);
  do
    echo -ne "$count seconds\033[0K\r"
    sleep 1
  done
}

# Creating docker network
current_action="Network creation"
echo
echo "Creating network named 'pfa'..."
text_to_grey
docker network create pfa
error_treatment

# Creating MySQL container
current_action="MySQL container creation"
echo
echo "Creating database container..."
text_to_grey
docker run --name pfa-mysql -h 127.0.0.1 -p 3306 --network=pfa -d dnbtr/pfa-mysql
error_treatment

# Wait until MySQL is ready for connections...
echo
echo "Waiting 15 seconds until database is ready..."
countdown_fifteen
until docker exec -i pfa-mysql mysql -uroot -pmysql -e "show databases" > /dev/null 2>&1
do
  echo "Database not yet ready. Waiting 5 secs to try again..."
  countdown_five
done

# Populate the database
current_action="Database population"
echo
echo "Populating the database..."
text_to_grey
docker exec -i pfa-mysql mysql -pmysql < ./mysql/db-setup.sql > /dev/null 2>&1
error_treatment

# Querying the database and supressing warning message...
current_action="Database test query"
echo
echo "Querying data on the database..."
echo "SELECT COUNT(*) FROM fc_modules;"
text_to_grey
docker exec -i pfa-mysql mysql -uroot -pmysql -e "use fc; select count(*) from fc_modules;" 2>&1 | grep -v "Warning"
error_treatment

# Starting NodeJS container
current_action="NodeJS container initialization"
echo
echo "Starting NodeJS container..."
text_to_grey
docker run -d --name=pfa-node --network=pfa dnbtr/pfa-node npm run start
error_treatment

# Starting Nginx container
current_action="Nginx reverse shell container initialization"
echo
echo "Starting nginx reverse shell..."
text_to_grey
docker run -d --name=pfa-nginx --network=pfa -p 8888:80 dnbtr/pfa-nginx
error_treatment

echo
echo "${yellow}All done! Test a request to localhost:8888/fc_modules${reset}"
echo