---
name: form-config-response
description: Return normalized form configuration from a workflow name using the Portal API shape. Use when the user asks for form config, form structure, schema payload, or wants the exact response format for a workflow.
---

# Form Config Response

## Purpose

Produce a consistent, reusable response when a user provides a workflow name and asks for the current form configuration.

## Input

- `workflow_name` (string from user, case-insensitive match)

## Retrieval workflow

1. Fetch workflows from `GET /api/workflows`.
2. Match workflow by `name` case-insensitively.
3. If no match by exact normalized name, match by `displayName` or `alias`.
4. If still no match, return `not_found` result with close-name suggestions.
5. If workflow exists but `forms` is empty, return `no_form` result.
6. If multiple forms exist, return the most recently updated form (`updatedAt` desc) as `current_form` and include `all_form_ids`.

## Output contract

Always return JSON with this envelope:

```json
{
  "status": "ok | no_form | not_found",
  "workflow": {
    "id": "string",
    "name": "string",
    "alias": "string|null",
    "displayName": "string|null"
  },
  "current_form": {
    "id": "string",
    "name": "string",
    "description": "string|null",
    "updatedAt": "ISO-8601",
    "modelType": "Workflow",
    "modelId": "string",
    "payload": {
      "rjsf": {
        "schema": {},
        "uiSchema": {},
        "formData": {}
      },
      "attachments": {}
    }
  },
  "meta": {
    "matched_by": "name | displayName | alias",
    "all_form_ids": ["string"],
    "source": "GET /api/workflows"
  }
}
```

## Rules

- Preserve payload exactly; do not rename keys.
- Keep Thai/Unicode strings unchanged.
- Do not flatten or transform nested `rjsf` objects.
- If optional blocks are missing, return empty objects (`{}`) for `uiSchema`, `formData`, or `attachments`.
- If `status` is not `ok`, set `current_form` to `null`.
- Persist styling conventions; do not persist data defaults:
  - Keep visual conventions in `uiSchema` (for example `ui:options.suffix`, textarea widgets, placeholders, grid/table layout, column width rules).
  - Do not introduce or infer business default values in `formData` unless explicitly provided by the user.
- Date/date-time representation:
  - Keep date semantics in schema via `format: date` or `format: date-time`.
  - `uiSchema` date widget choice is optional and depends on user preference.
- Financial field representation:
  - Monetary display should use `ui:options.suffix` (for example `THB`) in `uiSchema` when the project convention uses currency suffixes.
  - Percentage/rate fields are typically represented without currency suffix.
- Attachment representation:
  - Attachments live under `payload.attachments` as keyed objects.
  - Each attachment entry supports:
    - `title` (string shown to user)
    - `required` (boolean)
  - Attachments-only forms may keep `rjsf.schema.properties` empty and `uiSchema.ui:order` empty.

## Examples

Date field in schema:

```json
{
  "start_date": {
    "type": "string",
    "title": "Start Date",
    "format": "date"
  }
}
```

Financial suffix in `uiSchema`:

```json
{
  "contract_value": {
    "ui:options": {
      "suffix": "THB"
    }
  }
}
```

Attachment block:

```json
{
  "attachments": {
    "evidence": {
      "title": "Receipt / Evidence / Supporting Documents",
      "required": true
    }
  }
}
```

Table/grid column width in `uiSchema`:

```json
{
  "cost_items": {
    "items": {
      "ui:field": "LayoutGridField",
      "ui:layoutGrid": {
        "ui:row": {
          "style": {
            "rowGap": "0.5rem",
            "columnGap": "0.5rem",
            "gridTemplateColumns": "3fr 1fr 1fr 1fr"
          },
          "children": [
            {
              "ui:columns": {
                "style": { "minWidth": 0 },
                "children": ["description", "quantity", "unit_price", "amount"]
              }
            }
          ]
        }
      }
    }
  }
}
```

## Short natural-language summary

Before JSON, provide 2-4 bullets:

- matched workflow name + workflow id
- selected form id + last updated timestamp
- whether conditional logic exists (from `schema.allOf`)
- attachment requirement summary
