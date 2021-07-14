docker kill `docker ps -q`

docker-compose up -d

cd host-disco
sh run.sh &
cd ..

sleep 5
echo "Fetching host info"
curl -s http://localhost:1500
sleep 2

docker-compose stop client-1
sleep 2
echo "Fetching host info"
curl -s http://localhost:1500


docker-compose stop client-2
sleep 2
echo "Fetching host info"
curl -s http://localhost:1500


docker-compose stop mosquitto
sleep 2
echo "Fetching host info"
curl -s http://localhost:1500


docker kill `docker ps -q`

