---
name: doa-source-reader
description: Read and cite the source Delegation of Authority (DOA/AOA) PDF. Use when the user asks to verify a rule against the source document, look up a clause not encoded in `doa-aoa-approver-decision`, quote exact wording, or resolve ambiguity in the encoded rule set.
---

# DOA Source Reader

## Purpose

Provide a single, deterministic way to locate and read the official DOA/AOA policy PDF so that approver-chain decisions can be verified against the source rather than inferred only from the encoded rule set.

## When To Use

- User asks "what does the DOA say about X" / "show me the clause" / "quote the policy".
- The encoded rules in `doa-aoa-approver-decision` are ambiguous, missing, or contested.
- A new process type, subtype, or threshold appears that is not covered by the encoded rules.
- Before updating `doa-aoa-approver-decision/SKILL.md` with new rules — always confirm against the source first.

## Source Location

Resolved in this order:

1. `DOA_SOURCE_PATH` from `.env.local` (preferred). May be:
   - A local path (relative to project root or absolute), e.g. `./storage/TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf`
   - An HTTP(S) URL.
2. Fallback default: `./storage/TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf`.

If the resolved path does not exist or the URL fails, return a clear error and stop — do not guess clause contents.

## Read Workflow

1. Resolve `DOA_SOURCE_PATH`.
2. For local paths: read the PDF directly with the Read tool, using the `pages` argument when the file is large (more than 10 pages).
3. For URLs: download to a temp file with curl, then read.
4. Identify the relevant section (process type / subtype / threshold) before quoting.
5. Quote the smallest fragment that proves the rule. Preserve original language (Thai or English) verbatim.

## Output Contract

Return:

- **Source**: resolved path or URL, plus page number(s) cited.
- **Quote**: exact wording from the document (in original language). Translate only if the user asks.
- **Interpretation**: 1-3 lines mapping the quote into the `doa-aoa-approver-decision` schema (`process_type`, `subtype`, `amount_thb` bucket, `required_approvers`, `final_approver`).
- **Discrepancy** (if any): note where the source disagrees with the encoded rule set, and recommend an update via `portal-skill-memory-loop`.

## Rules

- Never paraphrase a clause and present it as the rule. Quote first, interpret second.
- Never infer a threshold or approver chain that is not literally present in the document.
- If a rule applies under conditions (e.g. "within budget", "with related functional impact"), include the condition in the quote — do not strip qualifiers.
- If the document version in `DOA_SOURCE_PATH` differs from what the encoded rules were built against, flag the version mismatch and ask the user before treating the source as authoritative.

## Cross-Skill Handoff

- For applying rules and producing approver chains: use `doa-aoa-approver-decision`.
- For persisting newly discovered rules into the decision skill: use `portal-skill-memory-loop`.
- For mapping the resolved chain into Portal `steps`+`tasks`: use `portal-api-deterministic`.
