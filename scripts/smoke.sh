#!/bin/sh
set -eu
: "${BASE_URL:?Set BASE_URL}"
: "${ADMIN_PASSWORD:?Set ADMIN_PASSWORD}"
base=${BASE_URL%/}
[ "$(curl -fsS "$base/api/v1/health")" = "OK" ]
curl -fsS "$base/" | grep -qi 'kellnr'
status=$(curl -sS -o /tmp/kellnr-login-bad -w '%{http_code}' -H 'Content-Type: application/json' --data '{"user":"admin","pwd":"wrong-template-probe"}' "$base/api/v1/auth/login")
[ "$status" = "401" ]
status=$(curl -sS -c /tmp/kellnr-cookies -o /tmp/kellnr-login -w '%{http_code}' -H 'Content-Type: application/json' --data "{\"user\":\"admin\",\"pwd\":\"$ADMIN_PASSWORD\"}" "$base/api/v1/auth/login")
[ "$status" = "200" ]
grep -q '"is_logged_in":true' /tmp/kellnr-login
rm -f /tmp/kellnr-login-bad /tmp/kellnr-login /tmp/kellnr-cookies
printf '%s\n' 'Kellnr smoke checks passed'
