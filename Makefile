.PHONY: stop deploy build_auth build_board build_messenger build_core build_all

ENV_FILE := ./.env

stop:
	docker stack rm textneckhub

deploy:
	# 🚨🚨🚨 'source' 대신 '.' (점) 명령어로 교체! 🚨🚨🚨
	# 그리고 .env 파일이 없으면 경고를 띄우고 계속 진행합니다.
	-@test -f $(ENV_FILE) && . $(ENV_FILE) || echo "Warning: $(ENV_FILE) not found."
	docker stack deploy -c docker-stack.yml textneckhub

# 🚨🚨🚨 build_auth 타겟 수정! 🚨🚨🚨
build_auth:
	# 🚨🚨🚨 'source' 대신 '.' (점) 명령어로 교체! 🚨🚨🚨
	-@test -f $(ENV_FILE) && . $(ENV_FILE) || echo "Warning: $(ENV_FILE) not found."
	docker build \
	  -f Auth/Dockerfile.prod \
	  -t textneckhub-auth:v1.0.0 \
	  --build-arg DJANGO_SETTINGS_MODULE=config.settings.production \
	  --build-arg SECRET_KEY="${DJANGO_SECRET_KEY}" \
	  --build-arg DATABASE_URL="postgresql://$(AUTH_DB_USER):$(AUTH_DB_PASSWORD)@postgres-auth:5432/$(AUTH_DB_NAME)" \
	  --build-arg JWT_ACCESS_TOKEN_LIFETIME_MINUTES="${JWT_ACCESS_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_REFRESH_TOKEN_LIFETIME_DAYS="${JWT_REFRESH_TOKEN_LIFETIME_DAYS}" \
	  --build-arg JWT_ROTATE_REFRESH_TOKENS="${JWT_ROTATE_REFRESH_TOKENS}" \
	  --build-arg JWT_BLACKLIST_AFTER_ROTATION="${JWT_BLACKLIST_AFTER_ROTATION}" \
	  --build-arg JWT_ALGORITHM="${JWT_ALGORITHM}" \
	  --build-arg JWT_USER_ID_CLAIM="${JWT_USER_ID_CLAIM}" \
	  --build-arg JWT_JTI_CLAIM="${JWT_JTI_CLAIM}" \
	  --build-arg JWT_AUDIENCE="${JWT_AUDIENCE}" \
	  --build-arg JWT_ISSUER="${JWT_ISSUER}" \
	  --build-arg JWT_SLIDING_TOKEN_LIFETIME_MINUTES="${JWT_SLIDING_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS="${JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS}" \
	  Auth/

# 🚨🚨🚨 build_board, build_messenger, build_core 타겟도 유사하게 수정해야 합니다! 🚨🚨🚨
# (각 서비스의 DATABASE_URL 조합은 해당 서비스에 맞게 변경)
build_board:
	-@test -f $(ENV_FILE) && . $(ENV_FILE) || echo "Warning: $(ENV_FILE) not found."
	docker build \
	  -f Board/Dockerfile.prod \
	  -t textneckhub-board:v1.0.0 \
	  --build-arg DJANGO_SETTINGS_MODULE=config.settings.production \
	  --build-arg SECRET_KEY="${DJANGO_SECRET_KEY}" \
	  --build-arg DATABASE_URL="postgresql://$(BOARD_DB_USER):$(BOARD_DB_PASSWORD)@postgres-board:5432/$(BOARD_DB_NAME)" \
	  --build-arg JWT_ACCESS_TOKEN_LIFETIME_MINUTES="${JWT_ACCESS_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_REFRESH_TOKEN_LIFETIME_DAYS="${JWT_REFRESH_TOKEN_LIFETIME_DAYS}" \
	  --build-arg JWT_ROTATE_REFRESH_TOKENS="${JWT_ROTATE_REFRESH_TOKENS}" \
	  --build-arg JWT_BLACKLIST_AFTER_ROTATION="${JWT_BLACKLIST_AFTER_ROTATION}" \
	  --build-arg JWT_ALGORITHM="${JWT_ALGORITHM}" \
	  --build-arg JWT_USER_ID_CLAIM="${JWT_USER_ID_CLAIM}" \
	  --build-arg JWT_JTI_CLAIM="${JWT_JTI_CLAIM}" \
	  --build-arg JWT_AUDIENCE="${JWT_AUDIENCE}" \
	  --build-arg JWT_ISSUER="${JWT_ISSUER}" \
	  --build-arg JWT_SLIDING_TOKEN_LIFETIME_MINUTES="${JWT_SLIDING_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS="${JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS}" \
	  Board/

build_messenger:
	-@test -f $(ENV_FILE) && . $(ENV_FILE) || echo "Warning: $(ENV_FILE) not found."
	docker build \
	  -f Messenger/Dockerfile.prod \
	  -t textneckhub-messenger:v1.0.0 \
	  --build-arg DJANGO_SETTINGS_MODULE=config.settings.production \
	  --build-arg SECRET_KEY="${DJANGO_SECRET_KEY}" \
	  --build-arg DATABASE_URL="postgresql://$(MESSENGER_DB_USER):$(MESSENGER_DB_PASSWORD)@postgres-messenger:5432/$(MESSENGER_DB_NAME)" \
	  --build-arg JWT_ACCESS_TOKEN_LIFETIME_MINUTES="${JWT_ACCESS_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_REFRESH_TOKEN_LIFETIME_DAYS="${JWT_REFRESH_TOKEN_LIFETIME_DAYS}" \
	  --build-arg JWT_ROTATE_REFRESH_TOKENS="${JWT_ROTATE_REFRESH_TOKENS}" \
	  --build-arg JWT_BLACKLIST_AFTER_ROTATION="${JWT_BLACKLIST_AFTER_ROTATION}" \
	  --build-arg JWT_ALGORITHM="${JWT_ALGORITHM}" \
	  --build-arg JWT_USER_ID_CLAIM="${JWT_USER_ID_CLAIM}" \
	  --build-arg JWT_JTI_CLAIM="${JWT_JTI_CLAIM}" \
	  --build-arg JWT_AUDIENCE="${JWT_AUDIENCE}" \
	  --build-arg JWT_ISSUER="${JWT_ISSUER}" \
	  --build-arg JWT_SLIDING_TOKEN_LIFETIME_MINUTES="${JWT_SLIDING_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS="${JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS}" \
	  Messenger/

build_core:
	-@test -f $(ENV_FILE) && . $(ENV_FILE) || echo "Warning: $(ENV_FILE) not found."
	docker build \
	  -f Core/Dockerfile.prod \
	  -t textneckhub-core:v1.0.0 \
	  --build-arg DJANGO_SETTINGS_MODULE=config.settings.production \
	  --build-arg SECRET_KEY="${DJANGO_SECRET_KEY}" \
	  --build-arg DATABASE_URL="postgresql://$(CORE_DB_USER):$(CORE_DB_PASSWORD)@postgres-core:5432/$(CORE_DB_NAME)" \
	  --build-arg JWT_ACCESS_TOKEN_LIFETIME_MINUTES="${JWT_ACCESS_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_REFRESH_TOKEN_LIFETIME_DAYS="${JWT_REFRESH_TOKEN_LIFETIME_DAYS}" \
	  --build-arg JWT_ROTATE_REFRESH_TOKENS="${JWT_ROTATE_REFRESH_TOKENS}" \
	  --build-arg JWT_BLACKLIST_AFTER_ROTATION="${JWT_BLACKLIST_AFTER_ROTATION}" \
	  --build-arg JWT_ALGORITHM="${JWT_ALGORITHM}" \
	  --build-arg JWT_USER_ID_CLAIM="${JWT_USER_ID_CLAIM}" \
	  --build-arg JWT_JTI_CLAIM="${JWT_JTI_CLAIM}" \
	  --build-arg JWT_AUDIENCE="${JWT_AUDIENCE}" \
	  --build-arg JWT_ISSUER="${JWT_ISSUER}" \
	  --build-arg JWT_SLIDING_TOKEN_LIFETIME_MINUTES="${JWT_SLIDING_TOKEN_LIFETIME_MINUTES}" \
	  --build-arg JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS="${JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS}" \
	  Core/

build_all: build_auth build_board build_messenger build_core
	@echo "All service images built successfully! 🎉"