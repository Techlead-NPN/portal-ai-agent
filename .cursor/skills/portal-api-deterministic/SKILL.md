---
name: portal-api-deterministic
description: Deterministic API request runner for the Portal UAT endpoints. Use when calling portal APIs, validating auth, or testing endpoint behavior with stable curl commands and reproducible defaults.
---

# Portal API Deterministic

## Purpose

Run Portal UAT API requests in a deterministic way:
- Same base URL/auth source each run.
- Same headers and timeout each run.
- Stable command names for each endpoint/method.

## Configuration

Preferred:
- `.env.local` with:
  - `API_BASE_URL=...`
  - `API_BEARER_TOKEN=Bearer ...`

Fallback:
- `endpoint.txt`
- `jwt.txt`

## Execute

From project root:

```bash
bash .cursor/skills/portal-api-deterministic/scripts/api.sh users-list
```

With path params:

```bash
REQUEST_ID=req_123 bash .cursor/skills/portal-api-deterministic/scripts/api.sh requests-get
```

With JSON body:

```bash
BODY='{"email":"demo@example.com","password":"secret"}' bash .cursor/skills/portal-api-deterministic/scripts/api.sh auth-login
```

Preferred (avoid shell escaping mistakes):

```bash
BODY="$(jq -nc --arg email "demo@example.com" --arg password "secret" '{email:$email,password:$password}')" \
  bash .cursor/skills/portal-api-deterministic/scripts/api.sh auth-login
```

## Endpoint Commands

- `auth-login` -> `POST /api/auth/login`
- `health` -> `GET /api/health`
- `users-list` -> `GET /api/users`
- `users-me` -> `GET /api/users/me`
- `entities-list` -> `GET /api/entities`
- `step-types` -> `GET /api/steps/types`
- `step-approval-modes` -> `GET /api/steps/approval-modes`
- `workflows-list` -> `GET /api/workflows`
- `requests-list` -> `GET /api/requests`
- `requests-create` -> `POST /api/requests`
- `requests-me` -> `GET /api/requests/me`
- `requests-get` -> `GET /api/requests/{id}` (`REQUEST_ID`)
- `requests-update` -> `PUT /api/requests/{id}` (`REQUEST_ID`, optional `BODY`)
- `requests-delete` -> `DELETE /api/requests/{id}` (`REQUEST_ID`)
- `requests-steps` -> `GET /api/requests/{id}/steps` (`REQUEST_ID`)
- `requests-submit` -> `POST /api/requests/{id}/submit` (`REQUEST_ID`)
- `requests-cancel` -> `POST /api/requests/{id}/cancel` (`REQUEST_ID`)
- `requests-action-task` -> `POST /api/requests/{id}/action-task` (`REQUEST_ID`, optional `BODY`)
- `requests-preview` -> `GET /api/requests/{id}/preview` (`REQUEST_ID`)
- `requests-media` -> `GET /api/requests/{id}/media` (`REQUEST_ID`)
- `requests-add-participant` -> `POST /api/requests/{id}/participants` (`REQUEST_ID`, optional `BODY`)
- `requests-remove-participant` -> `DELETE /api/requests/{id}/participants` (`REQUEST_ID`, `PARTICIPANT_ID`)
- `action-log-types` -> `GET /api/action-logs/types`
- `action-log-object-types` -> `GET /api/action-logs/object-types`
- `action-log-me` -> `GET /api/action-logs/me`
- `comments-list` -> `GET /api/requests/{request}/comments` (`REQUEST_ID`)
- `comments-create` -> `POST /api/requests/{request}/comments` (`REQUEST_ID`, optional `BODY`)
- `comment-update` -> `PATCH /api/comments/{comment}` (`COMMENT_ID`, optional `BODY`)
- `comment-delete` -> `DELETE /api/comments/{comment}` (`COMMENT_ID`)
- `form-get` -> `GET /api/forms/{id}` (`FORM_ID`)
- `form-update` -> `PUT /api/forms/{id}` (`FORM_ID`, optional `BODY`)
- `form-delete` -> `DELETE /api/forms/{id}` (`FORM_ID`)
- `forms-list` -> `GET /api/forms`
- `forms-create` -> `POST /api/forms` (optional `BODY`)
- `test-run` -> `POST /api/test` (optional `BODY`)

## Determinism Notes

- Uses fixed defaults: `Accept: application/json`, `Content-Type: application/json`, `--connect-timeout 10`, `--max-time 60`.
- Fails fast with clear messages if required IDs are missing.
- Uses explicit env vars for path params (`REQUEST_ID`, `PARTICIPANT_ID`, `COMMENT_ID`, `FORM_ID`).
- Every run prints an auditable trace with:
  - `=== REQUEST ===` block: command, method, URL, headers, body
  - `=== RESPONSE ===` block: full HTTP status line, response headers, and response JSON/body
  - Authorization header value is masked in the trace for safety.

## Body Safety Rules (Important)

- For non-GET/DELETE, `api.sh` sends `BODY` exactly as provided; if not provided, it sends `'{}'`.
- Always build complex JSON using `jq -nc` to avoid malformed payloads.
- `payloadJson` must be a JSON-encoded string for request-create flows (not an object).
- If API returns `Unexpected non-whitespace character after JSON`, the payload is malformed; rebuild `BODY` with `jq -nc` and retry.
- Never append manual trailing braces/brackets when composing inline JSON strings.

## Proven Request Creation Flow (All request types)

When creating any request record (`PR`, `PO`, `PROJ`, etc.), use this exact deterministic order:

1. Identify workflow and reference payload shape
   - `workflows-list` and select target workflow
   - `requests-get` on a known-good sample from that workflow when available
   - Reuse the sample `payloadJson` structure; only replace `rjsf.formData` values

2. Create draft request
   - `requests-create` with `title`, `workflowId`, `entityId`, and `payloadJson` (string)

3. Assign approver correctly (ACTION)
   - Do **not** use `requests-add-participant` for approver assignment.
   - Current API behavior: `requests-add-participant` creates `VIEW` participant(s) only.
   - To create real approvers, always send `steps` + `tasks` in `requests-create` (or `requests-update` while DRAFT):
     - `steps`: include an `APPROVE` step (e.g. `approvalMode: ANY`)
     - `tasks`: map `stepOrder` to `assignedUserId` for the approver user
   - Rule: every created request must include at least one approver step/task pair.
   - After submit/get, verify participant permission is `ACTION` and task status is `ACTIVE`.

4. Upload attachment file
   - Use `PUT /api/requests/{id}` as `multipart/form-data`
   - Use field name `requestAttachment` for file uploads on request endpoint
   - If using other field names (e.g. `default`), API returns validation error

5. Submit
   - `requests-submit`
   - Confirm response has `status: SUBMITTED`, `number` assigned, and `currentStepOrder: 1`

Approver-create example (JSON fields only):

```json
{
  "steps": [
    { "name": "Approver Step 1", "actionType": "APPROVE", "approvalMode": "ANY" }
  ],
  "tasks": [
    { "stepOrder": 1, "assignedUserId": "<approverUserId>" }
  ],
  "status": "SUBMITTED"
}
```

Reference upload example:

```bash
curl -sS -i -X PUT "$API_BASE_URL/api/requests/$REQUEST_ID" \
  -H "Authorization: $API_BEARER_TOKEN" \
  -H "Accept: application/json" \
  -F "requestAttachment=@/absolute/path/to/file.pdf;type=application/pdf"
```
