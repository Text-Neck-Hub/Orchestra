# .env 파일 (프로젝트 루트 디렉토리에 저장)

# -----------------------------------------------------------------------------
# 🚨🚨🚨 Django 및 JWT 공통 설정 (모든 서비스에서 동일하게 사용) 🚨🚨🚨
# -----------------------------------------------------------------------------

# Django의 SECRET_KEY (JWT 서명 키로도 사용)
# 매우 길고 무작위적인 문자열로 설정해야 합니다.
# python -c 'import os; print(os.urandom(50).hex())' 로 생성할 수 있습니다.
DJANGO_SECRET_KEY=your_very_long_and_random_secret_key_for_jwt_and_django

# JWT Access Token 유효 기간 (분 단위)
JWT_ACCESS_TOKEN_LIFETIME_MINUTES=5

# JWT Refresh Token 유효 기간 (일 단위)
JWT_REFRESH_TOKEN_LIFETIME_DAYS=1

# Refresh Token 회전 활성화 (True/False)
JWT_ROTATE_REFRESH_TOKENS=True

# 회전된 Refresh Token 블랙리스트 추가 활성화 (True/False)
JWT_BLACKLIST_AFTER_ROTATION=True

# JWT 알고리즘 (HS256, RS256 등)
JWT_ALGORITHM=HS256

# JWT 페이로드에 사용자 ID를 저장할 클레임 이름
JWT_USER_ID_CLAIM=user_id

# JWT JTI 클레임 이름
JWT_JTI_CLAIM=jti

# JWT Audience (토큰의 대상 - null 또는 특정 문자열)
# null은 따옴표 없이 그대로 null로 작성합니다.
JWT_AUDIENCE=null 

# JWT Issuer (토큰의 발행자 - null 또는 특정 문자열)
# null은 따옴표 없이 그대로 null로 작성합니다.
JWT_ISSUER=null

# JWT Sliding Token 유효 기간 (분 단위)
JWT_SLIDING_TOKEN_LIFETIME_MINUTES=5

# JWT Sliding Token Refresh 유효 기간 (일 단위)
JWT_SLIDING_TOKEN_REFRESH_LIFETIME_DAYS=1


# -----------------------------------------------------------------------------
# 🚨🚨🚨 데이터베이스 연결 정보 (원래 사용하던 값 그대로!) 🚨🚨🚨
# -----------------------------------------------------------------------------

# Auth 서비스 데이터베이스
AUTH_DB_USER=auth_user # 👈 원래 사용하던 사용자 이름
AUTH_DB_PASSWORD=auth_password # 👈 원래 사용하던 비밀번호
AUTH_DB_NAME=textneckhub_auth_db # 👈 원래 사용하던 DB 이름

# Board 서비스 데이터베이스
BOARD_DB_USER=board_user # 👈 원래 사용하던 사용자 이름
BOARD_DB_PASSWORD=board_password # 👈 원래 사용하던 비밀번호
BOARD_DB_NAME=textneckhub_board_db # 👈 원래 사용하던 DB 이름

# -----------------------------------------------------------------------------
# 🚨🚨🚨 기타 서비스별 환경 변수 (필요시 추가) 🚨-----------------------------------------------------------------------------

# ALLOWED_HOSTS (콤마로 구분된 문자열)
# 프로덕션에서는 실제 도메인과 API 도메인을 정확히 입력합니다.
ALLOWED_HOSTS=www.textneckhub.p-e.kr,api.textneckhub.p-e.kr,localhost