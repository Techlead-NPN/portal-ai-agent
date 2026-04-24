---
name: portal-skill-memory-loop
description: Keeps project API skills up to date after successful or failed experiments. Use when finishing Portal API tests, discovering payload/permission/upload edge cases, or when the user asks to remember new behavior for future runs.
---

# Portal Skill Memory Loop

## Purpose

Persist new API learnings into project skills immediately, so the same mistake is not repeated in future chats.

## When To Use

Use this skill whenever any of the following happens:

- A request succeeds only after changing payload shape, field names, or endpoint order.
- A request fails with a useful validation/permission error that changes how we should call APIs.
- A new proven workflow is discovered (for example: create -> assign -> upload -> submit).
- The user asks to "remember", "update skill", "relearn", or "don't forget this".

## Target Files

Primary:

- `.cursor/skills/portal-api-deterministic/SKILL.md`
- `.cursor/skills/portal-api-deterministic/scripts/api.sh` (only if helper behavior must change)

This skill itself:

- `.cursor/skills/portal-skill-memory-loop/SKILL.md`

## Update Workflow (Mandatory)

Follow this sequence every time:

1. Capture evidence
   - Keep the exact request method, path, and key body fields.
   - Keep the exact response status and key error/success fields.
2. Classify learning
   - `payload-shape`, `permission-model`, `multipart-upload`, `workflow-order`, or `other`.
3. Update skill docs
   - Add/modify concise rules in `portal-api-deterministic/SKILL.md`.
   - Prefer explicit "Do/Don't" guidance and one working example.
4. Update helper script (if needed)
   - Only if repeated friction can be removed safely (for example, body handling/log formatting).
5. Verify
   - Re-run the corrected API flow once.
   - Confirm the response proves the new rule.
6. Report back
   - Tell the user what changed in the skill and what behavior is now remembered.

## Rule Style

Write durable rules, not one-off story notes:

- Good: "`requests-add-participant` creates VIEW; approver ACTION must come from `steps` + `tasks`."
- Good: "Use multipart field `requestAttachment` for request-level file upload."
- Bad: "This failed earlier and then worked after trying again."

## Required Output In Chat

After updating memory, always provide:

- What was learned (1-3 bullets)
- Which file(s) were updated
- The canonical request pattern to use next time

## Compact Template

Use this template when adding new memory entries to `portal-api-deterministic/SKILL.md`:

```markdown
### Memory: <short title>
- Trigger: <when this applies>
- Do: <correct request pattern>
- Avoid: <known wrong pattern>
- Proof: <status/error snippet that validates rule>
```
