---
name: GENJO Project Context
description: Context for GENJO lead validation project — files, locations, analysis highlights for AState and TxState
type: project
originSessionId: 83b855a8-df64-4d9d-8a8a-0f47a2842d97
---
GENJO is a lead management and validation system for two US universities operating in Mexico: AState (ASUQ) and TxState (TXST_Mexico), operated by Court Avenue for Espacios para la Edu SAPI de CV.

**Why:** Leads come from two systems (MASTER = Genjo CRM, TRACK = Salesforce/Power BI export) and need to be reconciled monthly.

**How to apply:** When user mentions GENJO, leads, ASUQ, TXST, Master, Track, or validation files, this is the relevant project context.

## File locations (both drives)
- Google Drive: `Shared drives > COURT AVENUE > GENJO > GENJO-VALIDATIONS`
- OneDrive: `OneDrive - ESPACIOS PARA LA EDU SAPI DE CV > 2026`

## Key files (FTP_*.xlsx)
- `FTP_ASUQ_Monthly_Master_Borrar.xlsx` — Monthly AState (MASTER GENJO + 11 meses, 43,263 rows)
- `FTP_TXST_Mexico_Monthly_Master.xlsx` — Monthly TxState (MASTER TXST + 8 meses, 37,085 rows)
- `FTP_Monthly_Master_AState_TxState.xlsx` — Combined monthly (MASTER + TRACK REPORT + COMPARACION + 11 meses, 80,348 rows)
- `FTP_ASUQ_Weekly_Master.xlsx` — Weekly AState (51 semanas, 43,995 rows)
- `FTP_TXST_Weekly_Master.xlsx` — Weekly TxState (36 semanas, 38,102 rows)
- `FTP_Weekly_Master_AState_TxState.xlsx` — Combined weekly (51 semanas, 82,097 rows)
- `GENJO_Comparativo_MASTER_vs_TRACK_May2026.xlsx` — Flat table for Power BI (37,494 rows: Coincide/Solo MASTER/Solo TRACK)
- `GENJO_Proyecto_Contexto.md` — Full project documentation

## COMPARACION analysis filters
- TRACK: Ciclo = Fall 2026 or Spring 2026, Created Date >= Aug 2025
- MASTER: Lead Id not null, createdOn >= Aug 2025

## Key metrics (as of May 2026)
- TRACK filtered: 28,610 | MASTER filtered: 32,292
- In BOTH: 23,408 | Only TRACK: 5,202 | Only MASTER: 8,884
- Coincidence index overall: 79.9% (ranges from 28.3% in Aug 2025 to 92.2% in Mar-Apr 2026)

## Coverage
- ASUQ Monthly: Jun 2025 – Apr 2026
- TXST Monthly: Sep 2025 – Apr 2026
- ASUQ Weekly: May 2025 – Apr 2026
- TXST Weekly: Aug 2025 – Apr 2026
- TRACK REPORT: Aug 2025 – May 2026 (87 May leads pending in MASTER)

## People
- Enrique Rocha: erocha_ext@astate.edu.mx / enrique@ownmedia.com.mx
- Daniel García: dgarcia@astate.edu.mx
