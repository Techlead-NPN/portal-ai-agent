# Open Tasks — DOA V1.1 Cell-Value Verification

This file is the handoff brief for completing the DOA V1.1 rules MD. The current encoding (`TL_Delegation_of_Authority_V1.1_27-02-2026_Execution.md`) has every section, rule, description, and amount threshold captured from OCR. What remains: filling in the per-role cell values (A/V/A-1/V-2/etc.) for rows currently marked `confidence: needs-verify`.

## Prompt to start a fresh session

Paste this verbatim into a new session in this same repo (`/Users/sirawit/Projects/portal-ai-agent`):

---

> I need to finish encoding the DOA V1.1 rules matrix. The structure work is done — every rule row is in `.cursor/skills/doa-aoa-approver-decision/rules/TL_Delegation_of_Authority_V1.1_27-02-2026_Execution.md` with its description, amount thresholds, and `confidence: needs-verify` markers. What's left: read the per-role cell values from the source PDF and fill them in.
>
> **Source PDF**: `storage/TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf` (sha256 `e4429a1ce458b45298ebd42f7708875022125a90638d878da8e3f2d0eebe8010`).
>
> **PDF is image-based** — `pdftotext` returns empty. Pre-rendered page images are at `/tmp/doa-pages-hd/page-NN.png` (350 DPI, 4095×2896). If those have been wiped, regenerate with: `pdftoppm -r 350 -png "storage/TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf" /tmp/doa-pages-hd/page`.
>
> **OCR text** (Thai descriptions only — cell codes don't OCR cleanly): `/tmp/doa-ocr/page-NN.txt`. Regenerate with `tesseract` if missing.
>
> **Method that works for cell values**:
> 1. For each rule row marked `needs-verify`, identify its page from the rule MD.
> 2. Crop a tight horizontal strip around that row using ImageMagick:
>    ```bash
>    magick /tmp/doa-pages-hd/page-NN.png -crop 4095xH+0+Y +repage /tmp/doa-rows/page-NN-row-K.png
>    ```
>    where `H` ≈ 120-200 px tall and `Y` is the row's vertical offset. Read the cropped strip with the `Read` tool.
> 3. Always crop a column-header strip from the top of the same page (offset Y≈300, height≈250) and read it once per page so you know which column is which. Header order: `BOD | AC | EXCOM | CEO | President | CFO | CMO | CTO | CLO | CPO | VP/L4 | (procurement pages add: Procurement Mgr | Procurement Officer) | Mgr (Requesting Dpt.) | Officer (Requesting Dpt.) | หมายเหตุ`.
> 4. Update the rule row in the MD: replace the `confidence: needs-verify` block with the actual chain (e.g. `A(F) = BOD; A-1 = AC; V chain: EXCOM (V-2), CEO (V-1)`) and set `confidence: high`.
> 5. After every section is done, update the **Delta vs current SKILL.md** at the bottom of the rules MD with any newly confirmed discrepancies.
>
> **Action codes** (already documented in the MD's "Action codes" table):
> - `A(F)` = final approver (last in chain, decision concludes here)
> - `A`, `A-1`, `A-2`, `A-3` = sequential approvers; **lower number = later in chain** (`A-1` approves before `A`)
> - `V`, `V-1`, `V-2`, `V-3` = reviewers (not counted as approvers)
> - `S` = signer; `P` = preparer; blank/grey = no authority
>
> **Order to work in** (highest impact first):
> 1. **Section 2 (Procurement)** — these match Portal `requests-create` flows directly. Rules 2.1, 2.2, 2.3, 2.4 (especially the amount-band sub-rows).
> 2. **Section 1 (Budget & Strategy)** — especially rule 1.7 (Project approval, 5 amount bands).
> 3. **Section 4 (Investment)** — rules 4.1-4.5 amount bands.
> 4. **Section 5 (Finance)** — rules 5.3, 5.4, 5.5, 5.8, 5.12, 5.13 amount bands.
> 5. **Section 6 (Accounting)** — rule 6.13 amount bands.
> 6. **Section 7 (Legal)** — rules 7.1, 7.4 amount bands.
> 7. **Section 8 (HR)** — by-level rules; cells per level.
> 8. **Section 9 (IT)** — short, can do last.
> 9. **Section 10 (SET disclosure)** — already mostly captured (text-based, not matrix-based).
>
> **After cells are filled, regenerate the Delta report** at the bottom of the rules MD: confirm each `🔴 DISCREPANCY` row with what the PDF actually says vs what `../SKILL.md` currently encodes. Then update `../SKILL.md` to match the PDF.
>
> **Stop conditions**:
> - All `needs-verify` rows resolved → confidence: high or low (with reason).
> - Discrepancies between PDF and current SKILL.md fully documented → user can decide which to update.
> - Delta report contains a clear "rules to update in SKILL.md" section.
>
> Begin with the column-header confirmation for page 6, then rule 1.7, then move into section 2.

---

## Why this approach (context for the next agent)

The original session ran into PDF complexity: 23 pages, ~100 rules, 14-16 columns each. Reading every cell by image at full-page zoom was unreliable; OCR captured Thai descriptions cleanly but mangled the small role-code cells. The structure-first approach (this MD) lets the next agent focus narrowly on cell values without re-discovering the rule list.

## What NOT to do

- Don't re-OCR. Descriptions are already encoded.
- Don't paraphrase Thai descriptions. They're verbatim from the source.
- Don't pick a "closest" cell value when uncertain — mark `confidence: low` with a note.
- Don't skip the column-header confirmation step per page. Procurement pages add 2 columns and that has tripped up readings in the original pass.
