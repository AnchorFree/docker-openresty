.PHONEY: all release clean

REPO  ?= anchorfree
IMAGE ?= openresty

all: build

build:
	docker build -t $(REPO)/$(IMAGE) .
	docker image prune -f 

release: 
	docker push $(REPO)/$(IMAGE):latest

clean:
	docker rmi $(REPO)/$(IMAGE):latest
