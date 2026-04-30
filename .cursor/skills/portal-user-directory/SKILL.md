---
name: portal-user-directory
description: Resolve human role names (titles) from DOA/AOA decisions into concrete Portal user IDs by querying the Users API. Use when mapping `required_approvers` from `doa-aoa-approver-decision` into `tasks[].assignedUserId`, or when the user asks "who is the CEO / Head of X / Assistant CEO for Y".
---

# Portal User Directory

## Purpose

Bridge the gap between **role names** (the language the DOA/AOA policy speaks: "CEO", "Head of Procurement", "Assistant CEO – Finance") and **Portal user IDs** (what `requests-create` needs in `tasks[].assignedUserId`).

Without this skill, the DOA decision skill produces an ordered list of role labels and the deterministic-API skill cannot proceed — there is no `assignedUserId` to send.

## When To Use

- After `doa-aoa-approver-decision` returns `required_approvers` and we need to build `steps` + `tasks` for `requests-create` / `requests-update`.
- User asks "who is the CEO" / "who handles X approvals" / "show me all Assistant CEOs".
- Verifying that an approver title exists in the Portal directory before submitting a request.
- Detecting role ambiguity (multiple users sharing one title) so we can ask the user which one to assign.

## Source

`GET /api/users` via `portal-api-deterministic`:

```bash
bash .cursor/skills/portal-api-deterministic/scripts/api.sh users-list
```

User schema (from `api-spec.yaml`):

```json
{
  "id": "uuid",
  "email": "string",
  "displayName": "string|null",
  "title": "string|null"
}
```

The **`title`** field is the primary join key against DOA role names.

## Resolution Workflow

For each role name in `required_approvers`:

1. **Normalize** the role name: trim, collapse whitespace, lowercase for comparison only (preserve original for output).
2. **Exact-match** on `title` (case-insensitive). If exactly one match: done.
3. **Alias-match** if no exact match. Apply known aliases (see Alias Map below). Re-run exact match.
4. **Substring / token-match** as last resort (e.g., role "Assistant CEO – Finance" → titles containing both "assistant ceo" and "finance"). Mark as `match_quality: fuzzy`.
5. **Body / committee roles** ("Board of Directors", "Audit Committee", "Executive Committee", "Procurement Committee") are **collective bodies**, not single users. Do **not** silently pick a member. Return `match_quality: collective_body` and stop — ask the user how the body is represented in Portal (group account, designated chair, or out-of-system signoff).
6. **Multiple matches** → return all candidates with `match_quality: ambiguous` and ask the user to pick.
7. **Zero matches** → return `match_quality: not_found` with the closest 3 titles by token overlap as suggestions.

## Alias Map

Maintain in this skill, expand as project learns. Aliases are **directional** (DOA-name → Portal-title hint):

| DOA name (canonical)              | Portal title aliases (substrings to try) |
| --------------------------------- | ---------------------------------------- |
| `CEO`                             | `chief executive officer`, `ceo`         |
| `Assistant CEO`                   | `assistant ceo`, `asst. ceo`, `acceo`    |
| `Head of requesting department`   | requires user-supplied department context — never auto-resolve |
| `Authorized procurement authority`| `procurement`, `head of procurement`     |
| `Audit Committee`                 | **collective body** — do not auto-resolve |
| `Board of Directors`              | **collective body** — do not auto-resolve |
| `Executive Committee`             | **collective body** — do not auto-resolve |
| `Procurement Committee`           | **collective body** — do not auto-resolve |

When a new alias is discovered (a real Portal title that did not match anything in this map), append it here via `portal-skill-memory-loop`.

## Output Contract

For a single role lookup:

```json
{
  "query": "CEO",
  "matches": [
    {
      "id": "uuid",
      "displayName": "Somchai Example",
      "email": "somchai@techleadnpn.co.th",
      "title": "Chief Executive Officer",
      "match_quality": "exact | alias | fuzzy | ambiguous | collective_body | not_found"
    }
  ],
  "selected_user_id": "uuid | null",
  "needs_user_confirmation": false,
  "suggestions": ["closest title 1", "closest title 2"]
}
```

For a full DOA chain resolution, return an array of these objects — one per `required_approvers[i]`, in original order — plus a top-level `ready_for_tasks` boolean (true only when **every** entry has a `selected_user_id`).

## Mapping To Portal `tasks`

Once every entry resolves to a single `selected_user_id`, build:

```json
{
  "steps": [
    { "name": "Approver Step 1", "actionType": "APPROVE", "approvalMode": "ANY", "stepOrder": 1 },
    { "name": "Approver Step 2", "actionType": "APPROVE", "approvalMode": "ANY", "stepOrder": 2 }
  ],
  "tasks": [
    { "stepOrder": 1, "assignedUserId": "<resolved-id-1>" },
    { "stepOrder": 2, "assignedUserId": "<resolved-id-2>" }
  ]
}
```

`stepOrder` mirrors the DOA chain order. Final approver gets the highest `stepOrder`.

## Caching

`/api/users` is paginated and may grow. To avoid re-fetching every turn:

- Within a single chat session, fetch once and reuse the in-memory result for subsequent lookups.
- Across sessions there is no shared cache — always re-fetch at the start of a new task to pick up directory changes (joiners, leavers, title changes).
- Never persist the user list to disk in this repo (PII).

## Guardrails

- **Never invent a `userId`.** If resolution fails, surface the failure — do not pick "the closest one" silently.
- **Never auto-resolve a collective body** to one user. The DOA chain may legitimately require a body-level signoff that lives outside Portal; that is a product decision, not a guess.
- **Do not log emails or display names** into committed files. Skill examples here are illustrative; real lookups stay in chat.
- **Title ≠ permission.** Resolving a title to a user does not check whether that user has the rights to act on the target request — Portal enforces that on submit. Surface API errors verbatim if the action fails.

## Cross-Skill Handoff

- Upstream input: `doa-aoa-approver-decision` (provides `required_approvers` ordered list).
- Downstream consumer: `portal-api-deterministic` (consumes resolved `assignedUserId` in `requests-create` / `requests-update` body).
- Memory updates: `portal-skill-memory-loop` when new aliases or collective-body handling rules are discovered.
