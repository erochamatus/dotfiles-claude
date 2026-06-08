---
name: EEH Planeación 2027
description: Excel CPL por canal AState+TxState. Master TR único en ~/Downloads. Filtros canónicos documentados. Funneles visuales generados. Comparación con PBI BDD validada.
type: project
originSessionId: 8d238620-4970-4d63-886f-e4079ab66905
---
Proyecto de planeación 2027 para Arkansas State University + Texas State University vía Court Avenue. Incluye dos entregables: (1) PPTX ejecutivo de funnel/CPL, (2) Excel de Presupuestos con tabla de leads por canal y CPL por etapa.

**Why:** Presentación ejecutiva al cliente con análisis de funnel comparativo 2024–25 vs 2025–26, costo por lead (CPL) por canal y etapa.

**How to apply:** Al retomar, usar el master TR único (`Track_Record_Ak_2025-26.xlsx`) con los filtros canónicos documentados abajo. Todos los ciclos y ambas universidades están en ese archivo.

---

## Archivo Master (fuente única de verdad)

| Archivo | Ruta | Descripción |
|---------|------|-------------|
| **Track Record Master** | `~/Downloads/Track_Record_Ak_2025-26.xlsx` | **ÚNICO TR** — 70,845 filas · AState+TxState · todos los ciclos (F24/Sp24/F25/Sp25/F26/Sp26) · incluye todos los orígenes (Mkt Digital + Esfuerzo Campus + Llamada entrada + Web + MailChimp + Marketplace) |
| Excel CPL v4 | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/...Copia_v4.xlsx` | **ACTIVO** — WhatsApp corregido en las 3 filas WA + AGG + TOTAL PAID |
| SF Leads base | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/SF_leads_base_maestra.csv` | 84,792 filas · join por Lead ID para Lead Source (Google/Pmax/Apply Now) |
| Funnel CPL visual | `~/.claude/jobs/a9550654/tmp/funneles_ciclos.html` | **ACTIVO** — dark theme, tabs AState/TxState, 8 canales, 3 ciclos |
| Funnel BDD comparativo | `~/.claude/jobs/a9550654/tmp/funnel_tres.html` | 3 funneles: BDD Ref / PBI Live / TR — Fall 2026 |
| EEH PPTX final | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/EEH_final_31may2026.pptx` | Presentación 26 slides — aprobada may 31 |
| Scripts patch | `~/.claude/jobs/df353a38/patch_whatsapp.py` | ZIP surgery que escribió _v4.xlsx |

---

## Filtros canónicos para análisis de funnel (CRÍTICO)

```python
MASTER = '~/Downloads/Track_Record_Ak_2025-26.xlsx'

# Columnas (60 total — diferente al TR anterior de 61 cols):
# 0=Ciclo, 1=Company, 2=Origen del Prospecto, 3=LeadSource (NUEVO),
# 4=Equipo, 5=Created Date, 6=Origen Conjunto,
# 18=Cambió a Validado, 19=Cambió a Perfilado, 20=Cambió a Citado,
# 21=Cambió a Asistido, 22=Cambio a Cerrado Ganado,
# 23=Cambio a Cerrado Perdido, 24=Cambió a Perdido,
# 29=Fecha Admission Fee, 30=Fecha Itep, 33=Fecha Pago Down Payment,
# 35=Estado del Prospecto, 46=Leadid, 48=utm_source, 50=utm_id

# Filtros a aplicar SIEMPRE:
# 1. Ciclo == 'Fall 2026' | 'Fall 2025' | 'Fall 2024' | etc.
# 2. Company == 'AState' | 'TxState'
# 3. Equipo == 'Mkt Digital'   ← CRÍTICO para coincidir con PBI BDD
# 4. stage_date <= cutoff (sin filtro Created Date — metodología BDD PBI)

# Cutoffs por ciclo:
# Fall 2026 / Spring 2026 → 2026-05-31
# Fall 2025 / Spring 2025 → 2025-05-31
# Fall 2024 / Spring 2024 → 2024-05-31
```

---

## Filtros del PBI BDD (para referencia)

```
utm_id excluidos: dforce, eluniversal, QR_Kuthy, QR_Tajonar, reforma, study_portals
Origen Conjunto excluidos: Prospección Grupal, Recomendación Grupal, Deportivo Grupal
Tipo de Origen: Digital
Equipo efectivo: Mkt Digital (el filtro "Tipo Origen = Digital" equivale a esto)
```

---

## Validación TR vs PBI BDD (Fall 2026 AState — jun 7, 2026)

| Etapa | TR (master) | PBI Ref | Δ% | PBI Live | Δ% |
|-------|-------------|---------|-----|----------|-----|
| Lead | 9,871 | 9,761 | +1.1% | 9,593 | +2.9% |
| Validado | 4,829 | 4,867 | −0.8% | 4,825 | +0.1% |
| Citado | 1,699 | 1,714 | −0.9% | 1,698 | +0.1% |
| Asistido | 1,028 | 1,040 | −1.2% | 1,028 | 0.0% |
| AdmFee | 258 | 263 | −1.9% | 258 | 0.0% |
| ITEP | 217 | 223 | −2.7% | 217 | 0.0% |
| DP | 155 | 158 | −1.9% | 155 | 0.0% |

✅ Todos los stages dentro de ±3% — TR y PBI esencialmente coinciden.

## Validación TR vs PBI BDD (Fall 2025 AState — jun 7, 2026)

| Etapa | TR (master) | PBI Ref | Δ% | Nota |
|-------|-------------|---------|-----|------|
| Lead | 17,698 | 14,436 | +22.6% | ⚠️ Inflado — retroactivo |
| Validado | 4,485 | 4,526 | −0.9% | ✅ |
| Citado | 1,875 | 1,878 | −0.2% | ✅ |
| Asistido | 963 | 964 | −0.1% | ✅ |
| DP | 175 | 175 | 0.0% | ✅ |

⚠️ Lead F25 inflado +3,262 porque el master fue exportado jun 2026 (13 meses después del cutoff). Leads retroactivamente reclasificados como Fall 2025 después de mayo 2025. Para Lead count F25, usar PBI (14,436). Para stages Valid→DP, TR es confiable.

---

## Convención de ciclos (CRÍTICA)

| Salesforce Ciclo | Nuestro ciclo | Cutoff |
|-----------------|---------------|--------|
| Fall 2026 + Spring 2026 | C.2026 | 2026-05-31 |
| Fall 2025 + Spring 2025 | C.2025 | 2025-05-31 |
| Fall 2024 + Spring 2024 | C.2024 | 2024-05-31 |

Los archivos nombrados "2024-25" = Salesforce Fall 2025 + Spring 2025 = **C.2025**

---

## Clasificador de canal (para CPL por canal — usa SF_leads_base_maestra.csv + Leadid join)

```python
def classify(oc, op, us, ls):
    op_l = op.lower(); us_l = us.lower()
    if any(x in op_l for x in ('whatsapp','wapp')): return 'WhatsApp'
    if ls in ('CA_Facebook_Whatsapp','Whatsapp'): return 'WhatsApp'
    if ls == 'google_pmax': return 'Google Pmax'
    if ls in ('google','google_search','google_video','google_discovery'): return 'Google'
    if ls == 'Apply Now Slate': return 'Apply Now'
    if oc == 'Página Web Grupal': return 'Web'
    if oc in ('Marketplace Grupal','MailChimp Grupal'): return 'Marketplaces'
    if oc == 'Digital y Redes Grupal':
        if 'tiktok' in op_l or 'tiktok' in us_l: return 'TikTok'
        if us_l == 'google_pmax': return 'Google Pmax'
        if any(x in us_l for x in ('google','pmax','gdn','youtube')): return 'Google'
        return 'Meta'
    return None
# Join: Leadid[:15] → SF_leads_base_maestra col[1]=LeadID, col[11]=Lead Source
```

---

## Estado (jun 7, 2026)
✅ Master TR único — `Track_Record_Ak_2025-26.xlsx` (70,845 filas, todos ciclos, AState+TxState)
✅ Filtros canónicos validados contra PBI BDD (±3% en todos los stages)
✅ Funnel visual CPL por canal generado (8 canales, 3 ciclos, tabs AState/TxState)
✅ Comparación BDD 3 funneles generada (Fall 2026 cuadra, Fall 2025 Lead inflado)
⏳ Pendiente: Actualizar v4.xlsx con datos TxState (nueva hoja TXSTATE_CPL)
⏳ Pendiente: Recalcular funneles CPL por canal con master TR (reemplaza análisis anterior)

## Personas
- Cliente: Arkansas State University + Texas State University
- Enrique Rocha: enrique@ownmedia.com.mx / enrique.rocha@courtavenue.com
