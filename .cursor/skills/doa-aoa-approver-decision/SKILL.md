---
name: doa-aoa-approver-decision
description: Determine approval chains for DOA/AOA requests using process type, budget status, and amount thresholds, with exact approver order and final approver. Use when users ask who must approve PR, PO, expense, budget, strategy, procurement, or bidding steps.
---

# DOA/AOA Approver Decision

## Purpose

Resolve approvers and sequence from the DOA/AOA policy using deterministic rules.

## Core definitions

- `A(F)`: Final approver (must approve last).
- `A`, `A-1`, `A-2`: Approvers (must approve in sequence).
- `V`, `V-1`, `V-2`: Reviewers only (not counted as approvers).
- Always enforce lower level -> higher level -> final approver.

## Required inputs

Collect:

1. `process_type`: one of `budget`, `expense`, `pr`, `po`, `procurement_outside_budget`, `bidding`
2. `subtype`: specific action inside the process (for example `annual_budget`, `pr_cancellation`)
3. `amount_thb`: numeric amount (if amount-based)
4. `budget_status`: `within_budget`, `over_budget`, `no_budget` (if applicable)
5. `related_functions`: impacted functional lines (for functional Assistant CEOs)

If required inputs are missing, ask a concise clarification before deciding.

## Decision workflow

1. Identify `process_type` and `subtype`.
2. If amount-based, map `amount_thb` into the exact threshold bucket.
3. Apply the matching rule chain exactly as written below.
4. Include supporting reviewers separately (never mix them into the required approval chain).
5. If the task is to create/update a request in Portal:
   - Build `steps` and `tasks` from `required_approvers`.
   - Create one `APPROVE` step per approver in sequence (`stepOrder` ascending).
   - Create one task per step with `assignedUserId` from user lookup.
   - Use `steps` + `tasks` in `requests-create` or `requests-update` while DRAFT.
   - Do not use `requests-add-participant` for approver assignment.
6. Return:
   - `required_approvers` (ordered)
   - `final_approver`
   - `supporting_reviewers` (optional)
   - `decision_path` (which rule bucket was selected)

## Rule set

### 1) Budget and plan approval

- `annual_budget` or `strategy_change`
  - Required: `Audit Committee -> Board of Directors`
  - Final approver: `Board of Directors`
  - Supporting reviewers: `Executive Committee`, `CEO and functional executives`

- `investment_budget_capex`
  - Required: `Audit Committee -> Board of Directors`
  - Final approver: `Board of Directors`

- `carry_forward_investment_budget`
  - Required: `Audit Committee -> Board of Directors`
  - Final approver: `Board of Directors`

- `manpower_budget`
  - Required: `CEO -> Board of Directors`
  - Final approver: `Board of Directors`
  - Supporting reviewer: `Executive Committee`

- `budget_cancellation`
  - Required: `Audit Committee -> Board of Directors`
  - Final approver: `Board of Directors`

- `strategy_business_plan_org_structure`
  - Required: `Executive Committee -> CEO -> Board of Directors`
  - Final approver: `Board of Directors`

### 2) Expense approval

- `budget_status=within_budget`
  - Required: `Relevant Functional Assistant CEOs -> CEO`
  - Final approver: `CEO`
  - Note: include only related functional Assistant CEOs.

- `budget_status=over_budget` or `budget_status=no_budget`
  - If `amount_thb <= 100000` OR `percent_overrun <= 5%`:
    - Required: `CEO`
    - Final approver: `CEO`
  - Else if `amount_thb <= 500000`:
    - Required: `CEO`
    - Final approver: `CEO`
    - Supporting reviewers: `Functional executives`
  - Else if `amount_thb <= 5000000`:
    - Required: `CEO -> Board of Directors`
    - Final approver: `Board of Directors`
  - Else (`amount_thb > 5000000`):
    - Required: `CEO -> Board of Directors`
    - Final approver: `Board of Directors`

### 3) Purchase requisition (PR) within budget

- `1 <= amount_thb <= 100000`
  - Required: `Head of requesting department`
  - Final approver: `Head of requesting department`

- `100001 <= amount_thb <= 1000000`
  - Required: `CEO`
  - Final approver: `CEO`

- `1000001 <= amount_thb <= 5000000`
  - Required: `CEO`
  - Final approver: `CEO`

- `amount_thb > 5000000`
  - Required: `Assistant CEOs (relevant functions) -> CEO -> Executive Committee -> Board of Directors`
  - Final approver: `Board of Directors`

- `pr_cancellation`
  - Required: `Assistant CEOs -> CEO -> Executive Committee -> Board of Directors`
  - Final approver: `Board of Directors`

### 4) Purchase order (PO) within budget

- `1 <= amount_thb <= 100000`
  - Required: `Authorized procurement authority`
  - Final approver: `Authorized procurement authority`

- `100001 <= amount_thb <= 1000000`
  - Required: `CEO`
  - Final approver: `CEO`

- `1000001 <= amount_thb <= 5000000`
  - Required: `CEO -> Board of Directors`
  - Final approver: `Board of Directors`

- `amount_thb > 5000000`
  - Required: `Assistant CEOs -> CEO -> Board of Directors`
  - Final approver: `Board of Directors`

- `po_cancellation`
  - Required: `Assistant CEOs -> CEO -> Board of Directors`
  - Final approver: `Board of Directors`

### 5) Procurement outside budget

- `1 <= amount_thb <= 100000`
  - Required: `CEO -> Board of Directors`
  - Final approver: `Board of Directors`

- `100001 <= amount_thb <= 1000000`
  - Required: `Assistant CEOs -> CEO -> Board of Directors`
  - Final approver: `Board of Directors`

- `amount_thb > 1000000`
  - Required: `Executive Committee -> Assistant CEOs -> CEO -> Board of Directors`
  - Final approver: `Board of Directors`

### 6) Bidding process

- `approve_bidding_initiation`
  - Required: `CEO`
  - Final approver: `CEO`

- `appoint_procurement_committee`
  - Required: `CEO`
  - Final approver: `CEO`

- `approve_tor`
  - Required: `CEO`
  - Final approver: `CEO`

- `price_verification_benchmarking`
  - Required: `CEO`
  - Final approver: `CEO`

- `final_contract_high_value`
  - Required: `CEO -> Board of Directors` (when board escalation is applicable)
  - Final approver: `Board of Directors`
  - Supporting reviewer: `Procurement Committee`

## Output format

Return compact JSON:

```json
{
  "process_type": "string",
  "subtype": "string",
  "decision_path": "string",
  "required_approvers": ["Ordered approver 1", "Ordered approver 2"],
  "final_approver": "string",
  "supporting_reviewers": ["Optional reviewer roles"],
  "notes": ["Optional constraints or assumptions"]
}
```

## Guardrails

- Never treat reviewer roles (`V*`) as required approvers.
- Never skip sequence order.
- If a role says "relevant functions", include only impacted functional Assistant CEOs.
- For ties on threshold boundaries, use inclusive ranges exactly as specified.
- If policy context is ambiguous, return the best-fit chain and state assumption in `notes`.
- For Portal request creation, never leave approvers empty; `required_approvers` must map to `steps` + `tasks`.
