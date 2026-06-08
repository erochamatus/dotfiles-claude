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
# 3. Equipo == 'Mkt Digital'   ← canónico para PBI Presentación (referencia aprobada)
# 4. stage_date <= cutoff (sin filtro Created Date — metodología BDD PBI)

# Cutoffs por ciclo:
# Fall 2026 / Spring 2026 → 2026-05-31
# Fall 2025 / Spring 2025 → 2025-05-31
# Fall 2024 / Spring 2024 → 2024-05-31

# NOTAS SOBRE FILTROS (validado 7 jun 2026):
# - Mkt Digital cuadra con PBI Presentación ±1% en ambos ciclos ✅ (referencia oficial)
# - PBI Live F25 (captura actual SF) muestra stages más altos que Presentación (+3-16%)
#   → causa: reclasificación retroactiva de leads Mkt Digital → Mkt Orgánico entre 2025-2026
#   → para cuadrar con PBI Live F25 usar todos los equipos (OC filter, sin filtro Equipo)
# - PBI Live F26 cuadra con Mkt Digital ±1-3% (ciclo reciente, sin reclasificaciones aún)
# - Los leads Mkt Orgánico (230 en F25, 143 en F26) tienen utm_id (none)/tribalo/courtavenue
#   → no están en la lista de exclusión del PBI por utm_id
#   → PBI los excluye por Tipo de Origen (Equipo field)
#
# OC filter (Origen Conjunto) — para cuadrar con PBI Live F25:
PBI_OC = {
    'Digital y Redes Grupal',
    'Esfuerzo Campus Grupal',
    'Llamada entrada/Visita campus Grupal',  # ← con 'Grupal' al final
    'MailChimp Grupal',
    'Marketplace Grupal',
    'Página Web Grupal',
}
```

---

## Filtros del PBI BDD (verificados 8 jun 2026 — imágenes reales del PBI)

```
utm_id excluidos (REAL): SOLO dforce, QR_Kuthy, QR_Tajonar
  ← study_portals, eluniversal, reforma: NO se excluyen (estaban mal documentados)
  ← Para F25 AState: ninguno de los 3 excluidos aparece en los datos (0 leads) — sin efecto

Origen Conjunto incluidos: Digital y Redes Grupal, Esfuerzo Campus Grupal,
  Llamada entrada/Visita campus Grupal, MailChimp Grupal, Marketplace Grupal, Página Web Grupal
Origen Conjunto excluido: Deportivo Grupal
Sin filtro de Equipo (Mkt Digital / Mkt Orgánico ambos incluidos)

Filtro canónico TR para coincidir con PBI Live:
  OC filter (6 valores) + stage_date ≤ cutoff + sin filtro Equipo
  → F25 AState: Valid→DP match 0.0% exacto con PBI Live ✅
  → F26 AState: stages ligeramente altos (+1-6%) con OC filter; Mkt Digital = mejor match ±1-3%
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

**Filtro Mkt Digital → cuadra con PBI Presentación (referencia oficial)**

| Etapa | TR Mkt Dig | PBI Ref | Δ% | PBI Live | Δ% |
|-------|-----------|---------|-----|---------|-----|
| Lead | 17,698 | 14,436 | +22.6% ⚠️ | 14,281 | +23.9% ⚠️ |
| Validado | 4,485 | 4,526 | −0.9% ✅ | 4,647 | −3.5% |
| Perfilado | 1,910 | 1,913 | −0.2% ✅ | 2,062 | −7.4% |
| Citado | 1,875 | 1,878 | −0.2% ✅ | 2,026 | −7.5% |
| Asistido | 963 | 964 | −0.1% ✅ | 1,082 | −11.0% |
| AdmFee | 272 | 273 | −0.4% ✅ | 316 | −13.9% |
| ITEP | 257 | 258 | −0.4% ✅ | 297 | −13.5% |
| DP | 175 | 175 | 0.0% ✅ | 208 | −15.9% |

**Filtro OC (todos equipos) → cuadra con PBI Live (Salesforce actual)**

| Etapa | TR OC filter | PBI Live | Δ% |
|-------|-------------|---------|-----|
| Validado | 4,646 | 4,647 | −0.0% ✅✅ |
| Perfilado | 2,062 | 2,062 | 0.0% ✅✅ |
| Citado | 2,026 | 2,026 | 0.0% ✅✅ |
| Asistido | 1,082 | 1,082 | 0.0% ✅✅ |
| DP | 208 | 208 | 0.0% ✅✅ |

⚠️ Lead siempre inflado +3,200-3,650 por reclasificación retroactiva (export jun 2026, 13 meses post-cutoff). Usar PBI (14,436 Ref / 14,281 Live) para Lead count.

**Por qué difieren Mkt Digital y OC filter en F25:** 230 leads clasificados como Mkt Orgánico en el export de jun 2026 probablemente eran Mkt Digital cuando se generó la Presentación (2025). La reclasificación retroactiva los movió. El PBI Live (Salesforce actual) los incluye en su filter "Digital/OC", por eso el OC filter cuadra con PBI Live.

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
