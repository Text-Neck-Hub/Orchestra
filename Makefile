.PHONY: stop deploy build_auth build_board build_messenger build_core build_all

ENV_FILE := ./.env

stop:
	docker stack rm textneckhub

deploy:
	-@test -f $(ENV_FILE) && source $(ENV_FILE) || echo "Warning: $(ENV_FILE) not found."
	docker stack deploy -c docker-stack.yml textneckhub

build_auth:
	docker build \
	  -f Auth/Dockerfile.prod \
	  -t textneckhub-auth:v1.0.0 \
	  Auth/

build_board:
	docker build \
	  -f Board/Dockerfile.prod \
	  -t textneckhub-board:v1.0.0 \
	  Board/

build_messenger:
	docker build \
	  -f Messenger/Dockerfile.prod \
	  -t textneckhub-messenger:v1.0.0 \
	  Messenger/

build_core:
	docker build \
	  -f Core/Dockerfile.prod \
	  -t textneckhub-core:v1.0.0 \
	  Core/

build_all: build_auth build_board build_messenger build_core
	@echo "All service images built successfully! 🎉"