echo "Stopping container..."
docker stop pfa-mysql
docker rm pfa-mysql
echo
echo "Removing network..."
docker network rm pfa
echo
echo "Done."