#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
ENV_FILE="${ROOT_DIR}/.env.local"
ENDPOINT_FILE="${ROOT_DIR}/endpoint.txt"
JWT_FILE="${ROOT_DIR}/jwt.txt"

load_config() {
  if [[ -f "${ENV_FILE}" ]]; then
    # shellcheck disable=SC1090
    source "${ENV_FILE}"
  fi

  API_BASE_URL="${API_BASE_URL:-}"
  API_BEARER_TOKEN="${API_BEARER_TOKEN:-}"
  API_SPEC_PATH="${API_SPEC_PATH:-./api-spec.yaml}"

  if [[ -z "${API_BASE_URL}" && -f "${ENDPOINT_FILE}" ]]; then
    API_BASE_URL="$(<"${ENDPOINT_FILE}")"
  fi

  if [[ -z "${API_BEARER_TOKEN}" && -f "${JWT_FILE}" ]]; then
    API_BEARER_TOKEN="$(<"${JWT_FILE}")"
  fi

  API_BASE_URL="${API_BASE_URL%/}"
}

resolve_spec_path() {
  local raw="${API_SPEC_PATH}"
  case "${raw}" in
    /*|http://*|https://*) echo "${raw}" ;;
    *) echo "${ROOT_DIR}/${raw#./}" ;;
  esac
}

spec_fetch() {
  local target
  target="$(resolve_spec_path)"
  echo "=== SPEC ==="
  echo "source: ${target}"
  echo "=== CONTENT ==="
  case "${target}" in
    http://*|https://*)
      curl -fsS --connect-timeout 10 --max-time 60 \
        -H "Accept: application/yaml, application/json, text/plain, */*" \
        "${target}"
      ;;
    *)
      if [[ ! -f "${target}" ]]; then
        echo "Spec file not found: ${target}" >&2
        exit 1
      fi
      cat "${target}"
      ;;
  esac
}

require_var() {
  local value="$1"
  local name="$2"
  if [[ -z "${value}" ]]; then
    echo "Missing required value: ${name}" >&2
    exit 1
  fi
}

mask_token() {
  local token="$1"
  if [[ "${#token}" -le 12 ]]; then
    echo "***"
    return
  fi
  echo "${token:0:8}...${token: -4}"
}

print_request() {
  local command="$1"
  local method="$2"
  local url="$3"
  local body="${4:-}"
  local masked_auth
  masked_auth="$(mask_token "${API_BEARER_TOKEN}")"

  echo "=== REQUEST ==="
  echo "command: ${command}"
  echo "method: ${method}"
  echo "url: ${url}"
  echo "headers:"
  echo "  Authorization: ${masked_auth}"
  echo "  Accept: application/json"
  echo "  Content-Type: application/json"
  if [[ -n "${body}" ]]; then
    echo "body: ${body}"
  else
    echo "body: <none>"
  fi
}

build_path() {
  local key="${1:-}"
  case "${key}" in
    auth-login) echo "/api/auth/login" ;;
    health) echo "/api/health" ;;
    users-list) echo "/api/users" ;;
    users-me) echo "/api/users/me" ;;
    entities-list) echo "/api/entities" ;;
    step-types) echo "/api/steps/types" ;;
    step-approval-modes) echo "/api/steps/approval-modes" ;;
    workflows-list) echo "/api/workflows" ;;
    requests-list) echo "/api/requests" ;;
    requests-create) echo "/api/requests" ;;
    requests-me) echo "/api/requests/me" ;;
    requests-get) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}" ;;
    requests-update) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}" ;;
    requests-delete) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}" ;;
    requests-steps) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/steps" ;;
    requests-submit) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/submit" ;;
    requests-cancel) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/cancel" ;;
    requests-action-task) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/action-task" ;;
    requests-preview) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/preview" ;;
    requests-media) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/media" ;;
    requests-add-participant) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/participants" ;;
    requests-remove-participant)
      require_var "${REQUEST_ID:-}" "REQUEST_ID"
      require_var "${PARTICIPANT_ID:-}" "PARTICIPANT_ID"
      echo "/api/requests/${REQUEST_ID}/participants?id=${PARTICIPANT_ID}"
      ;;
    action-log-types) echo "/api/action-logs/types" ;;
    action-log-object-types) echo "/api/action-logs/object-types" ;;
    action-log-me) echo "/api/action-logs/me" ;;
    comments-list) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/comments" ;;
    comments-create) require_var "${REQUEST_ID:-}" "REQUEST_ID"; echo "/api/requests/${REQUEST_ID}/comments" ;;
    comment-update) require_var "${COMMENT_ID:-}" "COMMENT_ID"; echo "/api/comments/${COMMENT_ID}" ;;
    comment-delete) require_var "${COMMENT_ID:-}" "COMMENT_ID"; echo "/api/comments/${COMMENT_ID}" ;;
    form-get) require_var "${FORM_ID:-}" "FORM_ID"; echo "/api/forms/${FORM_ID}" ;;
    form-update) require_var "${FORM_ID:-}" "FORM_ID"; echo "/api/forms/${FORM_ID}" ;;
    form-delete) require_var "${FORM_ID:-}" "FORM_ID"; echo "/api/forms/${FORM_ID}" ;;
    forms-list) echo "/api/forms" ;;
    forms-create) echo "/api/forms" ;;
    test-run) echo "/api/test" ;;
    *)
      echo "Unknown command: ${key}" >&2
      usage
      exit 1
      ;;
  esac
}

build_method() {
  local key="${1:-}"
  case "${key}" in
    auth-login|requests-create|requests-submit|requests-cancel|requests-action-task|requests-add-participant|comments-create|forms-create|test-run) echo "POST" ;;
    requests-update|form-update) echo "PUT" ;;
    comment-update) echo "PATCH" ;;
    requests-delete|requests-remove-participant|comment-delete|form-delete) echo "DELETE" ;;
    *) echo "GET" ;;
  esac
}

usage() {
  cat <<'EOF'
Usage:
  bash .cursor/skills/portal-api-deterministic/scripts/api.sh <command>

Examples:
  bash .cursor/skills/portal-api-deterministic/scripts/api.sh users-list
  REQUEST_ID=req_123 bash .cursor/skills/portal-api-deterministic/scripts/api.sh requests-get
  BODY='{"foo":"bar"}' bash .cursor/skills/portal-api-deterministic/scripts/api.sh forms-create
  bash .cursor/skills/portal-api-deterministic/scripts/api.sh spec-fetch
EOF
}

main() {
  local command="${1:-}"
  if [[ -z "${command}" ]]; then
    usage
    exit 1
  fi

  load_config

  if [[ "${command}" == "spec-fetch" ]]; then
    spec_fetch
    return
  fi

  require_var "${API_BASE_URL}" "API_BASE_URL (.env.local or endpoint.txt)"
  require_var "${API_BEARER_TOKEN}" "API_BEARER_TOKEN (.env.local or jwt.txt)"

  local path method url
  path="$(build_path "${command}")"
  method="$(build_method "${command}")"
  url="${API_BASE_URL}${path}"
  local body=""
  if [[ "${method}" != "GET" && "${method}" != "DELETE" ]]; then
    if [[ -n "${BODY+x}" ]]; then
      body="${BODY}"
    else
      body='{}'
    fi
  fi

  print_request "${command}" "${method}" "${url}" "${body}"
  echo "=== RESPONSE ==="

  if [[ "${method}" == "GET" || "${method}" == "DELETE" ]]; then
    curl -sS -i --connect-timeout 10 --max-time 60 \
      -X "${method}" "${url}" \
      -H "Authorization: ${API_BEARER_TOKEN}" \
      -H "Accept: application/json" \
      -H "Content-Type: application/json"
  else
    curl -sS -i --connect-timeout 10 --max-time 60 \
      -X "${method}" "${url}" \
      -H "Authorization: ${API_BEARER_TOKEN}" \
      -H "Accept: application/json" \
      -H "Content-Type: application/json" \
      -d "${body}"
  fi
}

main "$@"
