#!/usr/bin/env bash
set -e

echo "[mongo-init] start"

DB_NAME="${MONGO_INITDB_DATABASE:-textneckhub_ai_db}"

if [ -z "$ALTER_APP_USER" ] || [ -z "$ALTER_APP_PASSWORD" ]; then
  echo "[mongo-init] ALTER_APP_USER/ALTER_APP_PASSWORD 미설정. 앱 유저 생성 건너뜀."
  exit 0
fi

mongosh --host localhost \
  -u "$MONGO_INITDB_ROOT_USERNAME" \
  -p "$MONGO_INITDB_ROOT_PASSWORD" \
  --authenticationDatabase "admin" <<'EOF'
const dbName = process.env.MONGO_INITDB_DATABASE || "textneckhub_alter_db";
const appUser = process.env.ALTER_APP_USER || "alter_user";
const appPass = process.env.ALTER_APP_PASSWORD || "alter";

const db = db.getSiblingDB(dbName);
const existing = db.getUser(appUser);

if (existing) {
  print(`[mongo-init] user ${appUser} already exists on ${dbName}, skip.`);
} else {
  db.createUser({
    user: appUser,
    pwd: appPass,
    roles: [{ role: "readWrite", db: dbName }]
  });
  print(`[mongo-init] created user ${appUser} on ${dbName}`);
}
EOF

echo "[mongo-init] done"