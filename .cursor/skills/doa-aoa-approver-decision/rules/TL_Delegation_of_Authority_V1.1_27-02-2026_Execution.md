---
source_pdf: TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf
source_pdf_path: storage/TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf
version: V1.1
effective_date: 2026-02-27
approved_by: ที่ประชุมคณะกรรมการบริษัท ครั้งที่ 1/2569
sha256: e4429a1ce458b45298ebd42f7708875022125a90638d878da8e3f2d0eebe8010
page_count: 23
encoded_at: 2026-04-29
encoder: claude-opus-4-7
encoding_method: |
  - Thai descriptions and section structure: extracted via tesseract OCR (tha+eng) on 350-DPI page renders.
  - Cell values (A/V/A-1/V-2 codes per role column): visually read from cropped page images.
  - Each rule row carries a `confidence` marker: high (cells read at tight crop), medium (cells read at quarter-page crop), needs-verify (chain not yet read at sufficient resolution).
language_policy: Thai descriptions preserved verbatim from PDF; cell-value codes are Latin (A, V, A-1, V-2, A(F), S, P).
---

# TL Delegation of Authority — V1.1 (27-02-2026 Execution)

> Encoded rule matrix derived from `TL_Delegation of Authority_V1.1_27-02-2026_Execution.pdf`.
> For application of these rules into approver chains, see `../SKILL.md`. To verify a clause against the source, use the `doa-source-reader` skill.

## Role legend (from page 4-5)

| Code | Thai | English | Notes |
|---|---|---|---|
| BOD | คณะกรรมการบริษัท | Board of Directors | Of TL or subsidiary, as applicable |
| AC | คณะกรรมการตรวจสอบ | Audit Committee |  |
| NRC | คณะกรรมการสรรหาและกำหนดค่าตอบแทน | Nomination & Remuneration Committee |  |
| EXCOM | คณะกรรมการบริหาร | Executive Committee |  |
| CEO | ประธานเจ้าหน้าที่บริหาร | Chief Executive Officer |  |
| President | ผู้จัดการใหญ่ | President |  |
| GC | ที่ปรึกษากฎหมาย (ทั่วไป) | General Counsel |  |
| CFO | ประธานเจ้าหน้าที่บริหารด้านการเงินบัญชี | Chief Financial Officer |  |
| CMO | ประธานเจ้าหน้าที่บริหารด้านการตลาด | Chief Marketing Officer |  |
| CTO | ประธานเจ้าหน้าที่บริหารด้านเทคโนโลยี | Chief Technology Officer |  |
| CLO | ประธานเจ้าหน้าที่บริหารด้านกฎหมาย | Chief Legal Officer |  |
| CPO | ประธานเจ้าหน้าที่บริหารด้านบุคคลและความสุขทาง | Chief People Officer |  |
| VP | ผู้อำนวยการ / รองผู้อำนวยการระดับสูง | Vice President | L4 |
| CS | เลขานุการบริษัท | Company Secretary |  |
| Mgr | ผู้จัดการ | Manager | L3 |
| Dpt | ฝ่าย | Department | Various functions |

## Action codes

| Code | Thai meaning | Behavior |
|---|---|---|
| `A(F)` | อำนาจอนุมัติคนสุดท้าย | Final approver — last in the chain. Decision concludes here. |
| `A`, `A-1`, `A-2`, `A-3` | อำนาจอนุมัติตามลำดับขั้น | Sequential approver. Lower-numbered = later in chain (`A-1` approves before `A`). Rejection at any level = request returned/cancelled. |
| `V`, `V-1`, `V-2`, `V-3` | พิจารณากลั่นกรอง และลงนามรับทราบ | Reviewer / acknowledgement signer. Validates correctness before passing to approver. Not counted as approver. |
| `S` | ลงนามในเอกสาร | Document signer |
| `P` | ผู้จัดทำเอกสารและเดินเรื่องเอกสาร | Document preparer / process driver |
| (blank / grey) | | No authority — cannot approve or review this row |

**Chain ordering rule**: read approvers in numeric order from highest number to lowest, ending with `A(F)`. Example: `A-2 → A-1 → A(F)` means three sequential approvers; the holder of `A-2` reviews first, then `A-1`, then `A(F)` is the final approver.

## Standing footer (applies to every rule unless overridden)

> **หมายเหตุ:** รายการระหว่างกัน รายการที่เกี่ยวโยงกัน หรือรายการที่เข้าข่ายเป็นการได้มาหรือจำหน่ายไปซึ่งสินทรัพย์ของบริษัทจดทะเบียน ให้ดำเนินการอนุมัติตามที่กฎหมายกำหนด

> **Note (translation, for reader convenience only):** Related-party transactions, connected transactions, or transactions that fall under acquisition/disposal of assets of a listed company must follow the approval procedure prescribed by law (overrides the matrix below).

---

## Section 1 — งบประมาณและแผนงาน (Budget & Strategy) — page 6

### 1.1 การอนุมัติงบประมาณประจำปี และการอนุมัติปรับเปลี่ยนกลยุทธ์และงบประมาณ
- **Page**: 6
- **Translation**: Approval of annual budget and approval of strategy/budget changes
- **Approval chain**:
  - **A(F)** = BOD (final approver)
  - **A-1** = AC
  - **V** chain: EXCOM (V-3), CEO (V-2), President + CFO + CMO + CTO + CLO + CPO + VP (V-1)
- **Confidence**: medium

### 1.2 การอนุมัติงบประมาณรายจ่ายการลงทุนประจำปี
- **Page**: 6
- **Translation**: Approval of annual investment expenditure budget (CAPEX)
- **Approval chain**:
  - **A(F)** = BOD
  - **A-1** = AC
  - **V** chain: EXCOM (V-2), CEO (V-1)
- **Confidence**: medium

### 1.3 การอนุมัติโอนงบประมาณรายจ่ายการลงทุนไปปีต่อไป
- **Page**: 6
- **Translation**: Approval of carry-forward investment budget to next year
- **Approval chain**:
  - **A(F)** = BOD
  - **A-1** = AC
  - **V** chain: EXCOM (V-2), CEO (V-1)
- **Confidence**: medium

### 1.4 การยกเลิกงบประมาณทั้งหมดหรือบางส่วน
- **Page**: 6
- **Translation**: Cancellation of approved budget (whole or partial)
- **Approval chain**:
  - **A(F)** = BOD
  - **A-1** = EXCOM
  - **A-2** = AC
  - **V** = CEO
- **Confidence**: medium

### 1.5 การอนุมัติกำหนดกลยุทธ์และแนวทางการดำเนินธุรกิจ (แผนงาน)
- **Page**: 6
- **Translation**: Approval of strategy and business direction (planning)
- **Approval chain**:
  - **A(F)** = BOD
  - **A-1** = EXCOM
  - **A-2** = AC
  - **V** = CEO
- **Confidence**: medium

### 1.6 การอนุมัติแผนการดำเนินงานประจำปี
- **Page**: 6
- **Translation**: Approval of annual operational plan
- **Approval chain**:
  - **A(F)** = BOD
  - **A-1** = EXCOM
  - **A-2** = AC
  - **V** = CEO
- **Confidence**: medium

### 1.7 การอนุมัติโครงการต่างๆ เพื่อดำเนินกิจกรรมตามแผนงาน และนอกเหนือแผนงาน
- **Page**: 6
- **Translation**: Project approvals (within plan and outside plan), by amount
- **By amount range**:

  | # | วงเงิน (THB) | Final approver | Chain | Confidence |
  |---|---|---|---|---|
  | 1.7.a | 1 – 100,000 | CFO/CMO/CTO/CLO/CPO (A) at function level | A | needs-verify |
  | 1.7.b | 100,001 – 1,000,000 | CEO (A) | CFO/CMO/CTO/CLO/CPO (V-2) → CEO (A) | needs-verify |
  | 1.7.c | 1,000,001 – 5,000,000 | EXCOM (A) or CEO (A-1)? | needs-verify | needs-verify |
  | 1.7.d | 5,000,001 – 10,000,000 | EXCOM/CEO chain | needs-verify | needs-verify |
  | 1.7.e | 10,000,001+ | BOD (A(F)) | AC (A-1) → EXCOM/CEO chain → BOD (A(F)) | needs-verify |

### 1.8 การอนุมัติกำหนด / เปลี่ยนแปลงโครงสร้างการบริหารองค์กร / นโยบายด้านการกำกับดูแลกิจการ / อำนาจอนุมัติ
- **Page**: 6
- **Translation**: Approval to set/change org structure / corporate governance policies / DOA itself
- **Approval chain**:
  - **A(F)** = BOD
  - **A-1** = EXCOM
  - **A-2** = AC
  - **V** = CEO
- **Confidence**: medium

### 1.9 การอนุมัติแนวการปฏิบัติงาน (Standard Operating Procedure)
- **Page**: 6
- **Sub-rules**:

  | # | Subtype | Final approver | Confidence |
  |---|---|---|---|
  | 1.9.1 | (1) แนวการปฏิบัติงานที่ใช้เป็นการทั่วไป (ใช้ตั้งแต่ 2 หน่วยงานขึ้นไป) | CEO (A) — chain CFO/CMO/CTO/CLO/CPO/VP (V-3) | medium |
  | 1.9.2 | (2) แนวการปฏิบัติงานที่ใช้เฉพาะหน่วยงานเดียว | Function head (A) at C-level | medium |

---

## Section 2 — การจัดซื้อจัดจ้าง (Purchasing) — page 7

> Procurement page adds two columns to the matrix: **Procurement Mgr** and **Procurement Officer**, plus **Mgr (Requesting Dpt.)** and **Officer (Requesting Dpt.)**.

### 2.1 ขั้นตอนปกติ — การขอจัดซื้อจัดจ้าง (Purchase Requisition – PR) ภายในงบประมาณ
- **Page**: 7
- **Translation**: Standard PR process within approved budget
- **By amount range**:

  | # | วงเงิน (THB) | Final approver | Chain (high level) | Confidence |
  |---|---|---|---|---|
  | 2.1.a | 1 – 100,000 | Function C-level (A) | Procurement Mgr (V-2), Officer (V-1), Requesting Mgr (V-1), Requesting Officer (P) | needs-verify |
  | 2.1.b | 100,001 – 1,000,000 | C-level (A) | VP (V-2 or A) → Procurement chain → Requesting chain | needs-verify |
  | 2.1.c | 1,000,001 – 5,000,000 | CEO (A(F)) | A-1 = function C-level chain | needs-verify |
  | 2.1.d | 5,000,001+ | CEO/BOD (A(F)) | A-1 chain via C-levels | needs-verify |

### 2.2 ขั้นตอนพิเศษ — PR นอกเหนืองบประมาณ (out of budget)
- **Page**: 7
- **By amount range**:

  | # | วงเงิน (THB) | Final approver | Confidence |
  |---|---|---|---|
  | 2.2.a | 1 – 1,000,000 | CEO (A(F)) with C-level A-1 chain | needs-verify |
  | 2.2.b | 1,000,001 – 5,000,000 | BOD (A(F))? CEO (A-1) | needs-verify |
  | 2.2.c | 5,000,001+ | BOD (A(F)) | needs-verify |

### 2.3 อำนาจอนุมัติการสั่งซื้อสั่งจ้างและยกเลิกการสั่งซื้อสั่งจ้าง — ใบสั่งซื้อ (Purchase Order – PO)
- **Page**: 7
- **By amount range**:

  | # | วงเงิน (THB) | Final approver | Confidence |
  |---|---|---|---|
  | 2.3.a | 1 – 1,000,000 | Procurement-level / function (A) | needs-verify |
  | 2.3.b | 1,000,001+ | CEO/BOD (A(F)), A-1 chain | needs-verify |

### 2.4 การประกวดราคาซื้อหรือว่าจ้างทำของ (Bidding Process)
- **Page**: 7
- **Sub-rules**:
  - 2.4.1 การพิจารณาการจัดให้มีการประกวดราคา (Approval to initiate bidding) — confidence: needs-verify
  - 2.4.2 การแต่งตั้งคณะกรรมการจัดซื้อจัดจ้าง / คณะกรรมการเปิดซองประกวดราคา (ถ้ามี) / คณะกรรมการตรวจรับ (Appoint procurement / bid-opening / acceptance committees)
  - 2.4.3 การอนุมัติข้อกำหนดขอบเขตงาน (TOR) — note: การลงนามต้องได้รับความเห็นชอบจากคณะกรรมการจัดซื้อจัดจ้างแล้ว
  - 2.4.4 การสืบราคาสินค้าและบริการ / การจัดทำราคากลาง (Price reference / fair-price determination)

### 2.5 รายจ่าย — Expenses (per procurement / bidding)
- **Page**: 7
- **Sub-rules**:
  - 2.5.1 การเบิกใช้รายจ่ายตามงบประมาณ (Within budget) — note: ลงนามเพื่อรับมอบสินค้า หรือรับมอบการจ้างงาน
  - 2.5.2 การเบิกใช้รายจ่ายเกินกว่าที่ได้รับอนุมัติตามงบประมาณ หรือไม่มีงบประมาณ (Over budget or no budget)
    - **By amount + percent overrun**:

      | # | วงเงิน | Note from PDF | Confidence |
      |---|---|---|---|
      | 2.5.2.a | ≤ 5% หรือไม่เกิน 100,000 บาท (whichever lower) | ลงนามเพื่อรับมอบสินค้าฯ | needs-verify |
      | 2.5.2.b | > 5% หรือไม่เกิน 500,000 บาท (whichever lower) | ลงนามเพื่อรับมอบสินค้าฯ | needs-verify |
      | 2.5.2.c | > 5% หรือไม่เกิน 5,000,000 บาท (whichever lower) | ลงนามเพื่อรับมอบสินค้าฯ | needs-verify |
      | 2.5.2.d | > 5,000,000 บาท | ลงนามเพื่อรับมอบสินค้าฯ | needs-verify |

### 2.6 การดำเนินการเรียกร้องค่าชดเชย / แลกเปลี่ยนสินค้าชำรุดเสียหาย หรือผิดวัตถุประสงค์
- **Page**: 7
- **Translation**: Damage claims / defective goods exchange / breach of purpose
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 2.6.a | 1 – 100,000 | needs-verify |
  | 2.6.b | 100,001 – 1,000,000 | needs-verify |
  | 2.6.c | 1,000,001 – 5,000,000 | needs-verify |
  | 2.6.d | 5,000,001+ | needs-verify |

- **Note**: ขั้นตอนและวิธีการดำเนินการเรียกร้องต้องได้รับความเห็นชอบจากประธานเจ้าหน้าที่บริหารด้านกฎหมายด้วย (must also be approved by CLO)

### 2.7 การประเมินผู้ขายหรือผู้ให้บริการทุกๆสิ้นปี
- **Page**: 8
- **Translation**: Annual vendor / service-provider evaluation
- **Note**: จัดซื้อส่งฟอร์มประเมินให้ผู้ใช้งานที่เกี่ยวข้องประเมินผู้ขายหรือผู้ให้บริการ (Procurement sends evaluation form to relevant users)
- **Confidence**: needs-verify

---

## Section 3 — การกำหนดราคาและเงื่อนไขการค้า (Pricing & Trade Terms) — page 9

### 3.1 การกำหนดราคาและเงื่อนไขการค้า
- **Page**: 9
- **Sub-rules**:
  - 3.1.1 การกำหนดหรือเปลี่ยนแปลงราคาสินค้า และ/หรือ ค่าบริการ ตามมาตรฐาน (Standard Price)
    - Note: EXCOM-TL, CEO – บ.แม่ /บริษัทย่อย
  - 3.1.2 การกำหนดข้อตกลง เงื่อนไขของสัญญาการค้าที่สำคัญของธุรกิจ (Commercial Terms) รวมทั้งการกำหนดนโยบายและระยะเวลาการชำระสินค้า และ/หรือค่าบริการ
- **Confidence**: needs-verify

### 3.2 การกำหนดโครงสร้างส่วนลด รวมถึง การกำหนดเงื่อนไขและขอบเขตการให้ส่วนลดแก่ลูกค้า
- **Page**: 9
- **Sub-rules**:
  - 3.2.1 ส่วนลดปกติ (Normal Discount)
  - 3.2.2 ส่วนลดเพิ่มเติม / ส่วนลดพิเศษ — ซึ่งไม่ต่ำกว่าต้นทุนผันแปรมาตรฐานของสินค้าและ/หรือบริการนั้นๆ (must not be below standard variable cost)
- **Note**: EXCOM-TL, CEO – บ.แม่ /บริษัทย่อย
- **Confidence**: needs-verify

### 3.3 การอนุมัติราคาสินค้า หรือค่าบริการ หลังหัก ส่วนลดปกติ และ/หรือส่วนลดเพิ่มเติม
- **Page**: 9
- **Sub-rules**:
  - 3.3.1 การมอบอำนาจให้ส่วนลดตามโครงสร้างส่วนลดที่ได้รับอนุมัติแล้วตามข้อ 2 ให้ผู้จัดการ / ผู้แทนขายเป็นครั้งคราว ภายใต้ขอบเขตของการมอบอำนาจ
- **Confidence**: needs-verify

### 3.4 การอนุมัติใบเสนอราคา (Quotation) เพื่อเสนอลูกค้า (ที่ได้รับอนุมัติตามข้อ 3)
- **Page**: 9
- **Confidence**: needs-verify

### 3.5 การลงนามในสัญญาขายสินค้า และ/หรือให้บริการ
- **Page**: 9
- **Note**: กรรมการผู้มีอำนาจของบ.ย่อย สามารถมอบอำนาจให้ CEO บริษัทย่อย ลงนามสัญญาได้ภายใต้กรอบการดำเนินการข้อ 1 ข้อ 2 ได้ (Subsidiary directors may delegate signing to subsidiary CEO within scope of items 1 and 2)
- **Signatory**: กรรมการผู้มีอำนาจลงนามตามหนังสือรับรอง (Authorized directors per certificate)
- **Confidence**: high (note authoritatively printed)

---

## Section 4 — การลงทุน (Investment) — page 10-11

### 4.1 การลงทุนในสินทรัพย์ถาวร เช่น ที่ดิน อาคาร สิ่งปลูกสร้าง
- **Page**: 10
- **Translation**: Investment in fixed assets (land, building, structures)
- **By amount range**:

  | # | วงเงิน (THB) | Final approver (likely) | Confidence |
  |---|---|---|---|
  | 4.1.a | ≤ 10,000,000 | CEO/EXCOM tier | needs-verify |
  | 4.1.b | 10,000,001 – 20,000,000 | EXCOM/BOD tier | needs-verify |
  | 4.1.c | 20,000,001+ | BOD (A(F)) | needs-verify |

### 4.2 การลงทุนในหลักทรัพย์ตราสารหนี้ รวมถึงการบริหารกระแสเงินสด (ระยะเวลาไม่เกิน 9 เดือน)
- **Page**: 10
- **Translation**: Investment in debt securities / cash management (≤ 9 months)
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 4.2.a | ≤ 10,000,000 | needs-verify |
  | 4.2.b | 10,000,001 – 50,000,000 | needs-verify |
  | 4.2.c | 50,000,001+ | needs-verify |

### 4.3 การลงทุนในหลักทรัพย์ตราสารหนี้ รวมถึงการบริหารกระแสเงินสด (ระยะเวลาเกิน 9 เดือน)
- **Page**: 10
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 4.3.a | ≤ 20,000,000 | needs-verify |
  | 4.3.b | 20,000,001+ | needs-verify |

### 4.4 การลงทุนในธุรกิจอื่น หรือการร่วมทุน
- **Page**: 10
- **Note**: พิจารณาขนาดรายการตามหลักเกณฑ์การได้มาหรือจำหน่ายไปซึ่งสินทรัพย์ และรายการที่เกี่ยวโยงกันของ ก.ล.ต. และการเปิดเผยสารสนเทศของตลาดหลักทรัพย์ฯ (Size assessment per SEC acquisition/disposal and connected-party rules + SET disclosure)
- **Sub-rules**:
  - 4.4.1 การลงทุนซื้อหุ้น / ขายหุ้นบริษัทอื่น ตามหลักเกณฑ์ที่คณะกรรมการบริษัทอนุมัติ
    - ≤ 20,000,000 baht — needs-verify
    - > 20,000,001 baht — needs-verify (likely BOD A(F))
  - 4.4.2 การร่วมทุน โดยมีส่วนร่วมในการบริหาร (JV with management role)

### 4.5 การว่าจ้างที่ปรึกษาด้านการลงทุน หรือผู้เชี่ยวชาญเฉพาะด้าน
- **Page**: 10
- **Translation**: Engagement of investment consultants / specialist advisors (FA, legal, valuation, fundraising)
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 4.5.a | ≤ 1,000,000 | needs-verify |
  | 4.5.b | 1,000,001 – 5,000,000 | needs-verify |
  | 4.5.c | 5,000,001 – 10,000,000 | needs-verify |
  | 4.5.d | 10,000,001+ | needs-verify |

### 4.6 การควบรวมกิจการ / การเลิกกิจการ / การขายกิจการ
- **Page**: 10
- **Translation**: M&A / dissolution / business sale
- **Final approver**: อนุมัติโดยที่ประชุมผู้ถือหุ้น (**Shareholder meeting** — outside Portal scope)
- **Confidence**: high

### 4.7 การเพิ่มทุน / ลดทุน
- **Page**: 11
- **Translation**: Capital increase / decrease
- **Final approver**: อนุมัติโดยที่ประชุมผู้ถือหุ้น (**Shareholder meeting**)
- **Confidence**: high

---

## Section 5 — การเงินและบัญชี — การเงิน (Finance) — page 12-14

### 5.1 การแต่งตั้ง หรือเปลี่ยนแปลงผู้มีอำนาจลงนามในเอกสารการเงิน
- **Page**: 12
- **Translation**: Appointment / change of authorized signatories on financial documents
- **Confidence**: needs-verify

### 5.2 การเปิดบัญชี / ปิดบัญชี ธนาคาร
- **Page**: 12
- **Translation**: Opening / closing bank accounts
- **Confidence**: needs-verify

### 5.3 การกู้ยืมเงินจากธนาคาร / สถาบันการเงิน
- **Page**: 12
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.3.a | ≤ 10,000,000 | needs-verify |
  | 5.3.b | 10,000,001+ | needs-verify |

### 5.4 การกู้ยืมเงิน / ให้กู้ยืมเงิน แก่บริษัทในเครือ และบุคคลภายนอก
- **Page**: 12
- **Includes**: เปลี่ยนแปลงจำนวนเงิน / ระยะเวลาการชำระเงิน / อัตราดอกเบี้ย / เงื่อนไขสัญญาอื่นๆ / หลักประกัน
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.4.a | ≤ 10,000,000 | needs-verify |
  | 5.4.b | 10,000,001 – 50,000,000 | needs-verify |
  | 5.4.c | 50,000,001+ | needs-verify |

### 5.5 การออกตั๋วสัญญาใช้เงิน เพื่อใช้ในกิจการของบริษัท
- **Page**: 12
- **Translation**: Issuance of promissory notes for company use
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.5.a | ≤ 10,000,000 | needs-verify |
  | 5.5.b | 10,000,001 – 50,000,000 | needs-verify |
  | 5.5.c | 50,000,001+ | needs-verify |

### 5.6 การกำหนดอัตราดอกเบี้ยเงินกู้ยืมระหว่างบริษัทในเครือ
- **Page**: 12
- **Note**: ควรเสนอ AC เพื่อให้พิจารณาการทำรายการระหว่างกันที่มีเงื่อนไขการค้าเป็นการทั่วไป (อย่างน้อยปีละ 1 ครั้ง) — should be presented to AC at least once per year
- **Confidence**: needs-verify

### 5.7 การออกตราสารหนี้
- **Page**: 12
- **Translation**: Bond issuance
- **Confidence**: needs-verify (likely BOD)

### 5.8 การอนุมัติเงินทดรองจ่ายต่อครั้ง (Advance payments per occurrence)
- **Page**: 12
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.8.a | 2,001 – 10,000 | needs-verify |
  | 5.8.b | 10,001 – 200,000 | needs-verify |
  | 5.8.c | 200,001 – 1,000,000 | needs-verify |
  | 5.8.d | 1,000,001+ | needs-verify |

### 5.9 การเคลียร์เงินทดรองจ่ายให้เป็นไปตามอำนาจอนุมัติค่าใช้จ่าย ตามงบประมาณ หรือนอกงบประมาณที่ได้รับอนุมัติแต่ละประเภท
- **Page**: 12
- **Confidence**: needs-verify

### 5.10 การอนุมัติจ่ายเงินสดย่อยต่อครั้ง ไม่เกิน 2,000 บาท
- **Page**: 12
- **Note**: ค่าใช้จ่ายประเภทที่สามารถเบิกเงินสดย่อยได้ให้เป็นไปตามระเบียบการเบิกเงินสดย่อย (per petty-cash regulation)
- **Confidence**: needs-verify

### 5.11 การอนุมัติวงเงินสดย่อย ไม่เกิน 20,000 บาท
- **Page**: 12
- **Confidence**: needs-verify

### 5.12 การอนุมัติลดหนี้ (Debt write-down)
- **Page**: 12
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.12.a | ≤ 100,000 | needs-verify |
  | 5.12.b | 100,001 – 200,000 | needs-verify |

### 5.13 การผ่อนผันการรับชำระหนี้ (Debt-collection deferral)
- **Page**: 13
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.13.a | ≤ 100,000 | needs-verify |
  | 5.13.b | 100,001 – 200,000 | needs-verify |
  | 5.13.c | 200,001+ | needs-verify |

### 5.14 การลงนามในเอกสาร ตราสาร และหนังสือสำคัญทางการเงิน
- **Page**: 13
- **Includes**: การออกหรือรับรองเช็ค / ตั๋วสัญญาใช้เงิน / ตั๋วแลกเงิน / การยินยอมให้ธนาคารหักบัญชีกระแสรายวัน / การรับรองหนี้สิน / การเปิด Letter of Credit / การขอให้ออกหนังสือค้ำประกัน
- **Note**: กรรมการ 2 คน ลงนามหนังสือมอบอำนาจให้ CEO, ผู้จัดการใหญ่ (2 directors sign POA delegating to CEO, President)
- **Signatory hint**: CFO
- **Confidence**: medium

### 5.15 การลงนามใบแจ้งหนี้ ใบกำกับภาษี ใบลดหนี้ ใบเพิ่มหนี้ การออกใบแทนใบกำกับภาษีให้แก่ลูกค้า
- **Page**: 13
- **Confidence**: needs-verify

### 5.16 การอนุมัติค่าใช้จ่ายที่ไม่ได้ผ่านการขอซื้อและการสั่งซื้อ (PR และ PO)
- **Page**: 13-14
- **Translation**: Approval of expenses bypassing PR/PO process
- **5.16.1 ตามงบประมาณและแผนกต่างๆ** — pre-approved categories:
  1. งบบุคลากร — รายจ่ายให้แก่บุคคลในงานบริหารบุคคล (เงินเดือน ค่าจ้างประจำ ค่าจ้างชั่วคราว ค่าตอบแทนอื่น)
  2. งบสาธารณูปโภค — ค่าน้ำ ค่าไฟฟ้า
  3. งบการปฏิบัติการด้านบัญชี — ค่าธรรมเนียมที่ต้องชำระแก่สรรพากร อากรแสตมป์ เบี้ยปรับ เงินเพิ่มต่างๆ ค่าสอบบัญชี ค่าธรรมเนียมใบอนุญาต
  4. งบการปฏิบัติการด้านกฎหมาย — ค่าธรรมเนียมการจดทะเบียน หรือยื่นคำขอต่างๆ ที่ต้องจ่ายให้หน่วยงานของรัฐ
  5. งบการปฏิบัติการด้านเลขานุการบริษัท — ค่าธรรมเนียมการที่ต้องจ่ายให้หน่วยงานของรัฐ (ตลาดหลักทรัพย์ฯ, ก.ล.ต., TSD, IOD, สมาคมเลขานุการบริษัทจดทะเบียน)
  6. งบค่าธรรมเนียมการตรวจสอบภายใน — ที่ได้รับอนุมัติจากคณะกรรมการตรวจสอบแล้ว
  7. งบค่าตอบแทนกรรมการ เบี้ยประชุม โบนัส และอื่นๆ — ที่ได้รับอนุมัติจากที่ประชุมผู้ถือหุ้นแล้ว
- **5.16.2 ค่าใช้จ่ายเลี้ยงรับรอง / ค่าของขวัญ ตามวงเงินงบประมาณ** ครั้งละ ไม่เกิน 2,000 บาท
  - Note: กรณีจัดหาของขวัญจำนวนมากในเทศกาลสำคัญ (ปีใหม่ ตรุษจีน) เพื่อเสริมภาพลักษณ์ ให้ผ่านกระบวนการจัดซื้อจัดจ้าง
- **5.16.2 over budget**:

  | # | วงเงิน (THB) per occurrence | Confidence |
  |---|---|---|
  | 5.16.2.a | ≤ 2,000 | needs-verify |
  | 5.16.2.b | 2,001 – 10,000 | needs-verify |
  | 5.16.2.c | 10,001+ | needs-verify |

- **5.16.3 การอนุมัติเงินบริจาค** ตามงบประมาณ — within budget
- **5.16.3 over budget**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 5.16.3.a | 1 – 100,000 | needs-verify |
  | 5.16.3.b | 100,001 – 1,000,000 | needs-verify |
  | 5.16.3.c | 1,000,001+ | needs-verify |

---

## Section 6 — การเงินและบัญชี — การบัญชี (Accounting) — page 15-16

### 6.1 การใช้หลักการบัญชี หรือเปลี่ยนแปลงหลักการบัญชีให้แตกต่างไปจากเดิม
- **Page**: 15
- **Note**: หากเป็นการเปลี่ยนแปลงนโยบายทางบัญชีที่สำคัญ ต้องเปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ฯ
- **Confidence**: needs-verify

### 6.2 การกำหนดหรือเปลี่ยนแปลงค่าเสื่อมราคา
- **Page**: 15
- **Note**: หากเป็นการเปลี่ยนแปลงนโยบายทางบัญชีที่สำคัญ ต้องเปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ฯ
- **Confidence**: needs-verify

### 6.3 การปฏิบัติทางบัญชี — Accounting practice
- **Page**: 15
- **Includes**: การอนุมัติใบสำคัญเพื่อลงบัญชี / การแก้ไขปรับปรุงการบันทึกบัญชี / การแจ้งเปิด/ปิดรหัสบัญชีใหม่ / การตรวจใบสำคัญ / การตรวจจ่าย
- **Confidence**: needs-verify

### 6.4 การตรวจสอบใบสำคัญทางบัญชี เพื่อลงบัญชี
- **Page**: 15
- **Sub-rules**:
  - 6.4.1 (1) เอกสารตั้งหนี้ (AP)
  - 6.4.2 (2) เอกสารจ่ายชำระหนี้ (PV)
  - 6.4.3 (3) เอกสารบันทึกการรับเงิน (RV)
  - 6.4.4 (4) เอกสารปรับปรุงทั่วไป (JV)
- **Confidence**: needs-verify

### 6.5 การปรับปรุงราคาต้นทุนมาตรฐาน
- **Page**: 15
- **Confidence**: needs-verify

### 6.6 การเปลี่ยนแปลงวิธีการปฏิบัติทางบัญชี
- **Page**: 15
- **Confidence**: needs-verify

### 6.7 การรับรอง / ยืนยัน / ขอคำรับรอง / ยืนยันยอดเจ้าหนี้ / ลูกหนี้ ตามบัญชี
- **Page**: 15
- **Confidence**: needs-verify

### 6.8 การปรับปรุงบัญชีภาษีซื้อ ภาษีขาย
- **Page**: 15
- **Confidence**: needs-verify

### 6.9 การลงนามหนังสือรับรองหัก ณ ที่จ่าย
- **Page**: 15
- **Confidence**: needs-verify

### 6.10 การลงนามในแบบแสดงรายการเพื่อเสียภาษี และขอคืนภาษี
- **Page**: 15
- **Signatory**: กรรมการผู้มีอำนาจลงนามตามหนังสือรับรอง (Authorized directors per certificate)
- **Sub-rules**:
  - 6.10.1 ภาษีเงินได้นิติบุคคล
  - 6.10.2 ภาษีมูลค่าเพิ่ม / ภาษีหัก ณ ที่จ่าย / ภาษีอื่นๆ
  - 6.10.3 การขอคืนภาษี
- **Confidence**: high (signatory printed)

### 6.11 การลงนามรับรองข้อมูลงบการเงิน และแบบแสดงรายการข้อมูลประจำปี (56-1 One Report)
- **Page**: 16
- **Final approver**: อนุมัติโดยที่ประชุมผู้ถือหุ้น (Shareholder meeting)
- **Confidence**: high

### 6.12 การลงนามใบแจ้งหนี้ ใบกำกับภาษี ใบลดหนี้ ใบเพิ่มหนี้ การออกใบแทนใบกำกับภาษีให้แก่ลูกค้า (duplicate of 5.15)
- **Page**: 16
- **Confidence**: needs-verify

### 6.13 การอนุมัติจำหน่ายทรัพย์สินของบริษัท / การตัดรายการสินทรัพย์ทางการเงินและหนี้สินทางการเงิน (Write-off)
- **Page**: 16
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 6.13.a | 1 – 100,000 | needs-verify |
  | 6.13.b | 100,001 – 1,000,000 | needs-verify |
  | 6.13.c | 1,000,001 – 5,000,000 | needs-verify |
  | 6.13.d | 5,000,001+ | needs-verify |

---

## Section 7 — กฎหมาย (Legal) — page 17

### 7.1 คดีความที่มีทุนทรัพย์ — Disputes with monetary value
- **Page**: 17
- **Includes**: การอุทธรณ์/ไม่อุทธรณ์ การประเมินภาษีอากร หรือการขอชำระภาษีอากร / การฟ้องคดี การต่อสู้คดี การอุทธรณ์ การฎีกา หรือการประนีประนอมยอมความ / การถอนฟ้องคดี การถอนอุทธรณ์ การถอนฎีกา / การไม่ฟ้องคดี การไม่ต่อสู้คดี การไม่อุทธรณ์ การไม่ฎีกา
- **By amount range**:

  | # | วงเงิน (THB) ต่อเรื่อง | Confidence |
  |---|---|---|
  | 7.1.a | ≤ 200,000 | needs-verify |
  | 7.1.b | 200,001 – 10,000,000 | needs-verify |
  | 7.1.c | 10,000,001+ | needs-verify |

### 7.2 คดีความที่ไม่มีทุนทรัพย์ หรือข้อพิพาททางอาญา — Cases without monetary value or criminal disputes (general business)
- **Page**: 17
- **Sub-rules**:
  - 7.2.1 แต่งตั้งทนายความดำเนินคดี
  - 7.2.2 ดำเนินคดีทางศาล
  - 7.2.3 ส่งเรื่องให้ที่ปรึกษากฎหมายภายนอกพิจารณา
  - 7.2.4 แจ้งความต่อเจ้าหน้าที่ตำรวจ
- **Scope**: ตามลักษณะการดำเนินธุรกิจทั่วไป และไม่มีผลกระทบอย่างมีนัยสำคัญต่อบริษัทหรืออยู่ภายใต้งบประมาณประจำปี
- **Confidence**: needs-verify

### 7.3 การพิจารณาดำเนินคดีความอันมีความเสี่ยงสูง — High-risk litigation
- **Page**: 17
- **Scope**: มีผลกระทบกับธุรกิจอย่างมีนัยสำคัญ หรือเกี่ยวข้องกับผู้บริหารระดับสูงหรือกรรมการของบริษัทในกลุ่ม
- **Sub-rules**:
  - 7.3.1 แต่งตั้งทนายความดำเนินคดี
  - 7.3.2 ดำเนินคดีทางศาล
  - 7.3.3 ส่งเรื่องให้ที่ปรึกษากฎหมายภายนอกพิจารณา
  - 7.3.4 แจ้งความต่อเจ้าหน้าที่ตำรวจ
- **Confidence**: needs-verify (likely BOD/AC chain)

### 7.4 การขอ Legal Opinion จากที่ปรึกษากฎหมายภายนอก หรือว่าจ้างที่ปรึกษากฎหมายอื่นๆ นอกเหนือจากการลงทุน
- **Page**: 17
- **By amount range**:

  | # | วงเงิน (THB) | Confidence |
  |---|---|---|
  | 7.4.a | ≤ 1,000,000 | needs-verify |
  | 7.4.b | 1,000,001+ | needs-verify |

---

## Section 8 — การบริหารทรัพยากรบุคคล (HR) — page 18-20

### 8.1 ระเบียบ/ข้อบังคับ โครงสร้าง และแนวทางปฏิบัติการบริหารงานบุคคล — การเปลี่ยนแปลงระเบียบ ข้อบังคับฯ และสภาพการจ้างงาน
- **Page**: 18
- **Confidence**: needs-verify

### 8.2 การเปลี่ยนแปลงระเบียบ แนวปฏิบัติที่เกี่ยวข้องกับงานบริหารทรัพยากรบุคคล สิทธิประโยชน์ของพนักงาน
- **Page**: 18
- **Confidence**: needs-verify

### 8.3 การกำหนดและทบทวนโครงสร้างองค์กร
- **Page**: 18
- **Confidence**: needs-verify

### 8.4 การกำหนดและทบทวนโครงสร้างของหน่วยงานระดับฝ่าย
- **Page**: 18
- **Confidence**: needs-verify

### 8.5 การกำหนดระดับ ตำแหน่งพนักงาน
- **Page**: 18
- **Confidence**: needs-verify

### 8.6 การแต่งตั้ง / ปรับเปลี่ยนตำแหน่ง / การโยกย้าย — by level
- **Page**: 18
- **Sub-rules**:
  - 8.6.1 ระดับพนักงาน (L1) – ผู้จัดการ (L3)
  - 8.6.2 ระดับผู้บริหารระดับกลาง (VP, Bu head) (L4)
  - 8.6.3 ระดับผู้บริหารระดับสูง (C-Level) (L5-L6) — note: CPO
- **Confidence**: needs-verify

### 8.7 การกำหนดโครงสร้างเงินเดือน
- **Page**: 18
- **Confidence**: needs-verify

### 8.8 การกำหนดงบประมาณกำลังคน / เงินเดือน / โบนัสประจำปี / เงินที่มีวัตถุประสงค์การจ่ายเข้าข่ายโบนัส
- **Page**: 18
- **Confidence**: needs-verify

### 8.9 การอนุมัติจ่ายเงินเดือน / ค่าจ้างประจำงวด
- **Page**: 18
- **Confidence**: needs-verify

### 8.10 การกำหนดโครงสร้างการจ่ายค่าตอบแทนตามผลงาน (Commission/Incentive)
- **Page**: 18
- **Confidence**: needs-verify

### 8.11 การอนุมัติทำงานล่วงเวลาและอนุมัติจ่ายค่าล่วงเวลา (OT)
- **Page**: 18
- **Note**: จ่าย OT เฉพาะ L1-L2 (ต่ำกว่าระดับผู้จัดการ)
- **Confidence**: high (note printed)

### 8.12 การปรับเงินเดือนทุกกรณี / การประเมินผลการปฏิบัติงาน — by level
- **Page**: 18
- **Sub-rules**:
  - 8.12.1 ระดับพนักงาน (L1) – ระดับผู้บริหาร (VP, Bu head) (L4)
  - 8.12.2 ระดับผู้บริหารระดับสูง (C-Level) (L5-L6)
- **Confidence**: needs-verify

### 8.13 การประกาศวันหยุดบริษัท / วันหยุดชดเชยกรณีพิเศษ
- **Page**: 19
- **Confidence**: needs-verify

### 8.14 การเปลี่ยนแปลงเวลาทำงานใหม่ทั้งหมดของบริษัท
- **Page**: 19
- **Confidence**: needs-verify

### 8.15 การบันทึกเวลาการทำงานและการรับรองการบันทึกเวลาทำงาน
- **Page**: 19
- **Note**: กรณีหน่วยงานที่ไม่ได้อยู่ในบังคับบัญชาของผู้ช่วยประธานเจ้าหน้าที่บริหาร ให้ผู้บริหารสูงสุดในสายงานเป็นผู้อนุมัติ
- **Confidence**: high (note printed)

### 8.16 การรับพนักงาน / การว่าจ้าง / การบรรจุ / การพ้นสภาพพนักงานด้วยความสมัครใจ — by level
- **Page**: 19
- **Sub-rules**:
  - 8.16.1 ระดับพนักงาน – ผู้จัดการ (L1-L3)
  - 8.16.2 ระดับผู้บริหารระดับกลาง (VP, Bu head) (L4) / ที่ปรึกษา
  - 8.16.3 ระดับผู้บริหาร (C-Level) (L5-L6) — note: คณะกรรมการสรรหาเป็นผู้กลั่นกรองก่อนเสนอ BOD (NRC pre-screens before BOD)
- **Confidence**: high for note; cells needs-verify

### 8.17 การพ้นสภาพพนักงานด้วยเหตุอื่น (involuntary termination) — by level
- **Page**: 19
- **Sub-rules**: (same level breakdown as 8.16)
- **Confidence**: needs-verify

### 8.18 การลาป่วย / ลากิจ / ลาพักผ่อน / ลาคลอด / ลารับราชการทหาร หรือลาอื่นๆ ตามระเบียบบริษัท — by level
- **Page**: 19
- **Sub-rules**:
  - 8.18.1 ระดับพนักงาน (L1-L2)
  - 8.18.2 ระดับผู้จัดการระดับต้น (L3)
  - 8.18.3 ระดับผู้บริหารระดับกลาง (VP, Bu head) (L4) — note: กรณีผู้บริหารระดับกลางไม่อยู่ในบังคับบัญชาของผู้ช่วยประธานเจ้าหน้าที่บริหาร ให้ผู้จัดการใหญ่เป็นผู้อนุมัติ
  - 8.18.4 ระดับผู้บริหาร (C-Level) (L5)
  - 8.18.5 ระดับผู้บริหาร (President/CEO) (L6)
- **Confidence**: high for notes; cells needs-verify

### 8.19 การลาโดยไม่รับค่าจ้าง
- **Page**: 19
- **Confidence**: needs-verify

### 8.20 การลาอื่นๆ นอกจากที่ระเบียบบริษัทกำหนด
- **Page**: 19
- **Confidence**: needs-verify

### 8.21 อนุมัติให้ปฏิบัติงานนอกเขตปฏิบัติงานปกติภายในประเทศ — Domestic travel by level
- **Page**: 20
- **Sub-rules**: (L1-L2, L3, L4, L5-L6, L6-President/CEO)
- **Note**: เบี้ยเลี้ยง ค่าที่พัก และค่าใช้จ่ายในการเดินทาง เป็นไปตามระเบียบบริษัท
- **Confidence**: needs-verify

### 8.22 อนุมัติให้ปฏิบัติงานนอกเขตปฏิบัติงานปกติต่างประเทศ — International travel by level
- **Page**: 20
- **Sub-rules**: (L1-L3, L4, L5-L6, L6 President/CEO)
- **Confidence**: needs-verify

### 8.23 การอนุมัติโครงการและงบประมาณฝึกอบรมพนักงานประจำปี
- **Page**: 20
- **Confidence**: needs-verify

### 8.24 การฝึกอบรมภายใน (Inhouse training)
- **Page**: 20
- **Confidence**: needs-verify

### 8.25 การฝึกอบรมภายนอก (Public Training) — by level
- **Page**: 20
- **Sub-rules**: (L1-L3, L4, L5-L6, L6 President/CEO)
- **Confidence**: needs-verify

### 8.26 หลักสูตรหรือโครงการพัฒนาบุคลากรนอกเหนืองบประมาณประจำปี
- **Page**: 20
- **Confidence**: needs-verify

---

## Section 9 — IT Management — page 21

### 9.1 การอนุมัติโครงการ TECH หรือโครงการที่ขออนุมัติเกี่ยวเนื่องกับธุรกิจ TECH นอกงบประมาณประจำปี
- **Page**: 21
- **Note**: โครงการ Tech คือ กิจกรรมด้านเทคโนโลยีที่เสนอขออนุมัติดำเนินการต่อคณะกรรมการบริหาร และคณะกรรมการบริษัท ตามกรอบวงเงินที่เสนอ
- **Confidence**: high (definition printed)

### 9.2 การอนุมัติให้ดำเนินการทดสอบเชิงพาณิชย์ (Commercial Test & Demos)
- **Page**: 21
- **Confidence**: needs-verify

### 9.3 การทำสัญญาทางการค้า / สัญญาการให้บริการที่มีเงื่อนไขนอกเหนือจากมาตรฐาน
- **Page**: 21
- **Scope**: ซึ่งก่อให้เกิดความเสี่ยงหรือภาระผูกพันที่มีนัยสำคัญ และ/หรือจำกัดสิทธิของบริษัท
- **Confidence**: needs-verify

### 9.4 การตรวจสอบบันทึกทรัพย์สินของบริษัท
- **Page**: 21
- **Confidence**: needs-verify

### 9.5 การอนุมัติเบิกอุปกรณ์ IT — by case
- **Page**: 21
- **Sub-rules**:
  - 9.5.1 กรณีพนักงานเข้าใหม่ — note: เจ้าหน้าที่ HRBP แจ้งพนักงานเข้าใหม่, IT ตรวจสอบ, People Manager อนุมัติ
  - 9.5.2 กรณีอนุมัติเพิ่มเติม / เปลี่ยนอุปกรณ์ IT (รวมถึงจอภาพ / docking)
- **Confidence**: high for new-hire flow note; sub-2 needs-verify

### 9.6 การอนุมัติ Email ให้แก่พนักงานเข้าใหม่ / การอนุมัติ share mailbox / mail กลาง เพิ่มเติม
- **Page**: 21
- **Note**: เจ้าหน้าที่ HR แจ้งเรื่องพนักงานเข้าใหม่
- **Confidence**: high

### 9.7 การอนุมัติเข้าถึงอีเมลของพนักงานที่ลาออกไปแล้ว
- **Page**: 21
- **Confidence**: needs-verify

### 9.8 การอนุมัติสร้าง Microsoft Teams เพิ่มเติม
- **Page**: 21
- **Confidence**: needs-verify

---

## Section 10 — การเปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ (SET / SEC Disclosure) — page 22-23

> Section 10 carries SEC/SET legal requirements that override the matrix. Always cross-check with current SEC and SET regulations.

### 10.1 การทำรายการที่เกี่ยวโยงกันตามหลักเกณฑ์ของ ก.ล.ต. (Connected transactions per SEC rules)
- **Page**: 22
- **By size**:

  | # | Size | Disclosure / Approver |
  |---|---|---|
  | 10.1.a | มูลค่า < 1 ล้านบาท หรือ < 0.03% ของ NTA (whichever higher) | (matrix-based) |
  | 10.1.b | 1 ล้านบาท ≤ มูลค่า < 20 ล้านบาท หรือ 0.03% NTA ≤ มูลค่า < 3% NTA (whichever higher) | เปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ฯ |
  | 10.1.c | มูลค่า ≥ 20 ล้านบาท หรือ มูลค่า ≥ 3% NTA (whichever higher) | เปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ฯ + FA + ผู้ถือหุ้นอนุมัติ |

- **Confidence**: high (thresholds printed)

### 10.2 รายการที่เกี่ยวโยงที่บริษัทหรือบริษัทย่อยให้ความช่วยเหลือทางการเงินแก่บุคคลที่เกี่ยวโยงกัน
- **Page**: 22
- **Scope**: หรือบริษัทที่บุคคลที่เกี่ยวโยงกันมีสัดส่วนการถือหุ้นมากกว่าสัดส่วนที่บริษัทหรือบริษัทย่อยถือ
- **By size**:

  | # | Size | Disclosure / Approver |
  |---|---|---|
  | 10.2.a | มูลค่า < 3% ของ NTA หรือ 100 ล้านบาท (whichever lower) | (matrix-based) |
  | 10.2.b | มูลค่า ≥ 3% NTA หรือ 100 ล้านบาท (whichever lower) | เปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ฯ + FA + ผู้ถือหุ้นอนุมัติ |

- **Confidence**: high

### 10.3 การได้มาหรือจำหน่ายไปซึ่งสินทรัพย์ตามหลักเกณฑ์ของ ก.ล.ต. (Asset acquisition/disposal per SEC rules)
- **Page**: 22
- **Calculation basis** (compare maximum of):
  1. เกณฑ์มูลค่าสินทรัพย์ที่มีตัวตนสุทธิ (Net Tangible Asset basis)
  2. เกณฑ์กำไรสุทธิจากการดำเนินงาน (Operating Net Profit basis)
  3. เกณฑ์มูลค่ารวมของสิ่งตอบแทน (Total Consideration basis)
  4. เกณฑ์มูลค่าหุ้นทุนที่ออกเพื่อชำระค่าสินทรัพย์ (Equity Issued basis)

- **By size**:

  | # | ขนาดรายการ | Disclosure / Approver |
  |---|---|---|
  | 10.3.a | < 15% | เปิดเผยสารสนเทศต่อตลาดหลักทรัพย์ฯ |
  | 10.3.b | < 15% และออกหุ้นเพื่อชำระค่าสินทรัพย์ | เปิดเผยต่อตลาดหลักทรัพย์ฯ + หนังสือเวียนถึงผู้ถือหุ้น ภายใน 21 วัน |
  | 10.3.c | 15% ≤ ขนาดรายการ < 50% | (per SEC class rules) |
  | 10.3.d | 50% ≤ ขนาดรายการ < 100% | ต้องเสนอ AC (ตามกฎบัตร), เปิดเผยต่อตลท., ขออนุมัติผู้ถือหุ้น และ FA ให้ความเห็น |
  | 10.3.e | ขนาดรายการ ≥ 100% (Backdoor Listing) | เปิดเผยต่อตลท., ขออนุมัติผู้ถือหุ้น และ FA ให้ความเห็น, ยื่นคำขอรับหลักทรัพย์ใหม่ |

- **Confidence**: high (thresholds and consequences printed)

### 10.4 การเปิดเผยสารสนเทศที่สำคัญตามหลักเกณฑ์ของตลาดหลักทรัพย์ฯ (SET disclosure)
- **Page**: 23
- **Sub-rules**:
  - 10.4.1 (1) การเปิดเผยตามระยะเวลาที่เกี่ยวกับผลการดำเนินงาน และงบการเงิน (Periodic — performance & financials)
  - 10.4.2 (2) การเปิดเผยตามระยะเวลาอื่นๆ (Other periodic)
  - 10.4.3 (3) การเปิดเผยตามเหตุการณ์สำคัญ (Material event)
- **Confidence**: needs-verify

---

## Open Questions / Verification Backlog

The following must be re-read at tight per-row image crops and the cell-value matrix completed (every `confidence: needs-verify` row above):

1. **Section 1.7 Project approval** — full A/V/A-1/V-2 chain per amount band (5 bands × 14-16 columns)
2. **Section 2 Procurement (all sub-rules)** — wide chains incl. Procurement Mgr / Officer / Requesting Mgr / Officer columns
3. **Sections 3-9** — every row marked `needs-verify`
4. **Section 10** — verify the matrix beyond the disclosure-text already captured

## Delta vs current `doa-aoa-approver-decision/SKILL.md`

Compared to the encoded rule set in `../SKILL.md` at time of writing:

- **STRUCTURE**: existing skill encodes 6 process buckets (`budget`, `expense`, `pr`, `po`, `procurement_outside_budget`, `bidding`). The source PDF has **10 sections**:
  1. Budget & Strategy
  2. Procurement (PR/PO/Bidding inside one section)
  3. Pricing & Trade Terms ← **MISSING in current skill**
  4. Investment ← **MISSING**
  5. Finance ← **partially overlaps with `expense` bucket**
  6. Accounting ← **MISSING**
  7. Legal ← **MISSING**
  8. HR ← **MISSING**
  9. IT ← **MISSING**
  10. SET disclosure ← **MISSING**

- **THRESHOLDS — Procurement (PR within budget)**:
  - PDF (rule 2.1): bands at 100k / 1M / 5M (4 bands: 1-100k, 100k-1M, 1M-5M, 5M+)
  - Current skill: bands at 100k / 1M / 5M (4 bands: 1-100k, 100k-1M, 1M-5M, 5M+) — ✅ aligned

- **THRESHOLDS — Procurement (out of budget) (rule 2.2)**:
  - PDF: 1-1M / 1M-5M / 5M+
  - Current skill (`procurement_outside_budget`): 1-100k / 100k-1M / 1M+
  - 🔴 **DISCREPANCY**: current skill bands are different. PDF uses 1M / 5M cutoffs; skill uses 100k / 1M.

- **THRESHOLDS — PO (rule 2.3)**:
  - PDF: 1-1M / 1M+
  - Current skill: 1-100k / 100k-1M / 1M-5M / 5M+
  - 🔴 **DISCREPANCY**: current skill has 4 bands; PDF has 2.

- **THRESHOLDS — Expense (within budget) does not appear as a stand-alone rule in the PDF**:
  - PDF treats it under §2.5 (procurement-related expense) with overrun-percent logic
  - Current skill: separate `expense` bucket with within/over-budget bands of 100k / 500k / 5M
  - 🔴 **DISCREPANCY**: PDF threshold logic uses **whichever-lower of percent (5%) and amount cap**, current skill uses amount-only.

- **MISSING IN CURRENT SKILL (high-impact)**:
  - Investment thresholds (10M/20M/50M)
  - Loan / promissory-note thresholds (10M/50M)
  - Petty-cash thresholds (2k/10k/200k/1M)
  - Bad-debt write-off (100k/200k)
  - Asset write-off (100k/1M/5M)
  - Legal-litigation amount thresholds (200k/10M)
  - Donations (100k/1M/1M+)
  - SEC connected-transaction NTA-percent thresholds (0.03%/3%)
  - SEC asset-acquisition class brackets (15%/50%/100%)

## Next-Session Continuation

To complete the cell-value matrix, run the prompt in `OPEN_TASKS.md` (created alongside) — it instructs a follow-up agent to read tight per-row image crops at `/tmp/doa-pages-hd/` and update only the rows marked `needs-verify` here.
