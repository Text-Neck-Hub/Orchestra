# production.env 파일

# Frontend Service
# 프론트엔드가 백엔드 API에 접근할 주소
VITE_API_URL=https://api.textneckhub.o-r.kr

# Auth Service (Django)
# 인증 서비스가 사용할 PostgreSQL DB 연결 정보
AUTH_DATABASE_URL=postgresql://postgres:postgres@postgres:5432/postgres
# 인증 서비스의 Django 설정 파일 경로
AUTH_DJANGO_SETTINGS_MODULE=config.settings.production
# 인증 서비스의 SECRET_KEY (프로덕션용 진짜 키!)
AUTH_SECRET_KEY='아무거나 사용'
# 인증 서비스의 허용 호스트 (프론트엔드 도메인 등)
AUTH_ALLOWED_HOSTS='www.textneckhub.com,api.textneckhub.o-r.kr'


# Board Service (Django)
# 게시판 서비스가 사용할 PostgreSQL DB 연결 정보
BOARD_DATABASE_URL=postgresql://postgres:postgres@postgres:5432/postgres
# 게시판 서비스의 Django 설정 파일 경로
BOARD_DJANGO_SETTINGS_MODULE=config.settings.production
# 게시판 서비스의 SECRET_KEY (프로덕션용 진짜 키!)
BOARD_SECRET_KEY='너만의_게시판_서비스_진짜_비밀_키'
# 게시판 서비스의 허용 호스트 (프론트엔드 도메인 등)
BOARD_ALLOWED_HOSTS='www.textneckhub.com,api.textneckhub.o-r.kr'


# Messenger Service
# 메신저 서비스가 사용할 MongoDB 연결 정보 (서비스 이름과 내부 포트 사용)
MESSENGER_MONGODB_URL=mongodb://mongodb:27017/
# 메신저 서비스 환경 (production)
MESSENGER_ENV=production


# Core Service
# 코어 서비스가 사용할 Redis 연결 정보 (서비스 이름과 내부 포트 사용)
CORE_REDIS_URL=redis://redis:6379/0
# 코어 서비스 환경 (production)
CORE_ENV=production


# Database Services (PostgreSQL, MongoDB, Redis)
# PostgreSQL DB 사용자 이름
POSTGRES_USER=postgres
# PostgreSQL DB 비밀번호
POSTGRES_PASSWORD=postgres

# MongoDB 연결 정보 
MONGODB_URL=mongodb://mongodb:27017/ 

# Redis 연결 정보
REDIS_URL=redis://redis:6379/0 # 필요하다면 추가

