@ECHO OFF
rem Stop all containers
FOR /f "tokens=*" %%i IN ('docker ps -q') DO docker stop %%i


docker-compose up -d

cd host-disco
start run.cmd > nul 2>&1 &
cd ..

timeout /t 5
echo Fetching host-info
curl -s http://localhost:1500
timeout /t 2

docker-compose stop client-1
timeout /t 2
echo Fetching host-info
curl -s http://localhost:1500

docker-compose stop client-2
timeout /t 2
echo Fetching host-info
curl -s http://localhost:1500

docker-compose stop mosquitto
timeout /t 2
echo Fetching host-info
curl -s http://localhost:1500

rem Stop all containers
FOR /f "tokens=*" %%i IN ('docker ps -q') DO docker stop %%i

