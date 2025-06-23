# Makefile

.PHONY: stop deploy build_auth build_board build_messenger build_core

# 스택을 중지하고 제거하는 타겟
stop:
	docker stack rm textneckhub

# 스택을 배포하는 타겟
deploy:
	docker stack deploy -c docker-stack.yml textneckhub

# Auth 서비스 이미지를 빌드하는 타겟
# USER_ID와 GROUP_ID는 현재 호스트의 값을 자동으로 가져와서 전달
build_auth:
	docker build \
	  -f Auth/Dockerfile.prod \
	  -t textneckhub-auth:v1.0.0 \
	  Auth/

# Board 서비스 이미지를 빌드하는 타겟
build_board:
	docker build \
	  -f Board/Dockerfile.prod \
	  -t textneckhub-board:v1.0.0 \
	  Board/

# Messenger 서비스 이미지를 빌드하는 타겟
build_messenger:
	docker build \
	  -f Messenger/Dockerfile.prod \
	  -t textneckhub-messenger:v1.0.0 \
	  Messenger/

# Core 서비스 이미지를 빌드하는 타겟
build_core:
	docker build \
	  -f Core/Dockerfile.prod \
	  -t textneckhub-core:v1.0.0 \
	  Core/

# 모든 서비스 이미지를 빌드하는 타겟
build_all: build_auth build_board build_messenger build_core
	@echo "All service images built successfully! 🎉"

