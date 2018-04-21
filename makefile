#########################################
#VARIABLES: CAN BE EDITED
#########################################

CONTAINER=debian-nginx-php

CONTNAME=$(CONTAINER)-1

DATAVOL=$(pwd)/vol


#net=host: mandatory for others containers to connect to mysql
STARTOPT=-d \
-p 8080:80 \
--link debian-mariadb-1:mysql \
-v $(DATAVOL)/www:/www \
-v $(DATAVOL)/conf:/etc/nginx/sites-available/ \
-v $(DATAVOL)/logs:/var/log/nginx/ \
--name $(CONTNAME) \
$(CONTAINER) /root/start.sh


#########################################
# ACTIONS: DO NOT EDIT BEYOND THIS POINT
#########################################

build:
	docker build -t $(CONTAINER) .

run:
	docker run $(STARTOPT)

bash:
	docker exec -i -t $(CONTNAME) /bin/bash

stop:
	docker stop $(CONTNAME)

delete:
	docker rm $(CONTNAME)

clear:
	docker rmi -f $(CONTAINER)

cleanupdb:
	make stop;make delete

restart:
	 make stop;make delete ;make build ;make run
