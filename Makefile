.PHONEY: all release openresty cli clean

REPO  ?= anchorfree
IMAGE ?= openresty

all: openresty cli

openresty:
	docker build -t $(REPO)/$(IMAGE) .
	docker image prune -f 

cli:
	docker build -f Dockerfile.cli -t $(REPO)/$(IMAGE):cli .
	docker image prune -f

release: 
	-docker push $(REPO)/$(IMAGE):latest
	-docker push $(REPO)/$(IMAGE):cli

clean:
	-docker rmi $(REPO)/$(IMAGE):cli
	-docker rmi $(REPO)/$(IMAGE):latest

