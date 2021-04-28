echo "Removing images..."
docker image rm dnbtr/pfa-node
docker image rm dnbtr/pfa-mysql
docker image rm dnbtr/pfa-nginx

echo
echo "Building pfa-node..."
docker build -t dnbtr/pfa-node ./node
echo
echo "Building pfa-mysql..."
docker build -t dnbtr/pfa-mysql ./mysql
echo
echo "Building pfa-nginx..."
docker build -t dnbtr/pfa-nginx ./nginx
echo
echo "Done."