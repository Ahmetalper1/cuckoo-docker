sudo docker-compose -f docker-compose.yml -f src/docker-compose.devel.yml build
sudo docker-compose -f docker-compose.yml -f src/docker-compose.devel.yml up

sudo docker-compose -f docker-compose.yml -f src/docker-compose.prod.yml build
sudo docker-compose -f docker-compose.yml -f src/docker-compose.prod.yml up
