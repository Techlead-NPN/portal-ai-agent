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
  - `API_SPEC_PATH=...` (local file path or HTTP(S) URL to the OpenAPI spec; defaults to `./api-spec.yaml`)

Fallback:
- `endpoint.txt`
- `jwt.txt`

## Spec lookup

Use `API_SPEC_PATH` when you need to inspect the OpenAPI definition:
- Local path (e.g. `./api-spec.yaml`): read the file directly.
- HTTP(S) URL (e.g. `https://uat-portal.api.techleadnpn.co.th/api-spec.yaml`): fetch with curl using the same auth headers as `api.sh` if the host requires it.

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
- `spec-fetch` -> prints the OpenAPI spec from `API_SPEC_PATH` (local file or HTTP(S) URL)

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

### Memory: Clone a form payload between workflows
- Trigger: user asks to make workflow B's form "the same as" workflow A's form.
- Do: resolve both workflows via `workflows-list` (match on `displayName`/`alias`, since several workflows share `name`), map each to its form via `forms-list`, back up the target form JSON under `storage/backups/`, then
  `BODY="$(jq -c '{name: .name, payload: .payload}' src.json)" FORM_ID=<targetFormId> ... form-update`.
- Avoid: sending `description`, `modelType`, or `modelId` — `PUT /api/forms/{id}` is a partial update and cannot change the morph; omitting `description` preserves the target's own wording.
- Proof: `HTTP/2 200`; re-fetching the target showed `{name, payload}` byte-identical to the source with `description` unchanged.
- Known pair: `Payment Request (PAY)` = `workflow_dCsaHdQmICWQx1NUXnOy3Bth` / `form_L30O0hYIiLjYtuBMTq053atH`; `Payment Request (Procurement)` (alias `PAYR`) = `workflow_jwGFQ4LqwKayHWACcVZ2FKgl` / `form_4ACezPtOwTNwzcS5q0d1Zvxo`.

### Memory: Clone a form payload from UAT to Prod
- Trigger: user asks to update a Prod workflow's form with the UAT version.
- Prod config lives in `.env.production.local` as `API_BASE_URL_PRODUCTION` / `API_BEARER_TOKEN_PRODUCTION` (`https://portal.api.techleadnpn.co.th`). `api.sh` cannot reach Prod — it sources `.env.local` last, so exported overrides are clobbered. Use a separate caller.
- Do **not** `source .env.production.local`: `API_BEARER_TOKEN_PRODUCTION=Bearer eyJ...` is unquoted, so bash splits on the space and tries to run the JWT as a command. Parse with
  `grep -m1 '^API_BEARER_TOKEN_PRODUCTION=' "$ENVF" | cut -d= -f2-`.
- Flow: resolve the workflow in each env via `GET /api/workflows` (match on `alias`), map to its form via `GET /api/forms` (match `modelId`), back up the Prod form's `.data` under `storage/backups/`, diff the schemas, then `PUT /api/forms/{prodFormId}` with `jq -c '{name, payload}'` from the UAT form.
- Always diff `.payload.rjsf.schema.properties` before writing and surface dropped/added fields — envs drift and the UAT form can be a *reduction* of Prod. Confirm with the user before overwriting Prod.
- Proof (2026-07-21): Prod `Payment Request` / `workflow_ZTL130zDILiLigGeCKpSK34X` / `form_9bHz7Z0xGqfMGpD9KOiIkF4p` updated from UAT `form_L30O0hYIiLjYtuBMTq053atH`; re-fetch showed `{name, payload}` byte-identical, `modelId` and `description` preserved. Overwrite dropped `account_code`, `expense_category`, `responsible_department` and added `due_date`.
- Note: that Prod form's `description` reads `"Petty Cash Request form"` — stale/wrong, but preserved since partial update omits `description`.

### Memory: Clone a form payload from Prod to UAT (reverse direction)
- Trigger: user asks to update a UAT workflow's form with the Prod version.
- Same mechanics as the UAT→Prod memory above, just swapped: read the source with the Prod caller, `PUT /api/forms/{uatFormId}` through `api.sh form-update` with `BODY="$(jq -c '{name, payload}' prod.json)"`.
- Do **not** match workflows on `alias` across envs — aliases drift. PR-EAP is `PR(EAP)` in Prod but `preap` in UAT. Match on `name`/`displayName`, then map to forms via `modelId`.
- A UAT workflow can have **more than one form attached**; `GET /api/workflows` returns a `forms[]` array per workflow. When it has several, list id/createdAt/updatedAt and ask the user which to overwrite rather than guessing.
- Proof (2026-08-17): UAT `Purchase Request (PR-EAP)` / `workflow_cSfs10qFi6LvXTMHh6HdQ3Xh` / `form_R4bixn8JED43SYcEtIQZXs79` updated from Prod `form_OgSEnJXIdbZcQ8idnwcax1qp` (`workflow_7qr8sQEX3IIeyPbgYJ6uYGmi`). `HTTP/2 200`; re-fetch showed `{name, payload}` byte-identical, `modelId`/`description` preserved. Overwrite dropped `total_expense`, added `isvat`, dropped `currency.default: "THB"`, and made `line_items[].amount` a computed read-only required field.
- Known duplicate: UAT workflow `workflow_cSfs10qFi6LvXTMHh6HdQ3Xh` has a second attached form `form_jM6MXlv1x5fKcrOq3doU0L28` (same name, missing `payload.budget`) that was left untouched.
