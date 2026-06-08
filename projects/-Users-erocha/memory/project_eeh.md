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

## Verificación filtros TxState (8 jun 2026) — CONFIRMADO con PBI

Scripts: `~/.claude/jobs/a9550654/tmp/verify_txstate.py`, `verify_txstate_c2026.py`, `recalc_txstate_oc.py`
Visual: `~/.claude/jobs/a9550654/tmp/funnel_tres_txstate.html`

**IMPORTANTE: TxState usa OC filter en TODOS los ciclos (diferente de AState).**
PBI Image #13 (TxState C.2026, 8 jun 2026): Lead=7,651 Valid=3,124 Cit=673 Asist=300 AdmFee=50 ITEP=42 DP=25

| Ciclo | Filtro | Resultado | Match PBI |
|-------|--------|-----------|-----------|
| **C.2026** | OC filter (F26+Sp26) | Lead=7,742 DP=25 | **0.0% ✅** confirmado |
| **C.2026** | Mkt Digital | Lead=7,715 DP=23 | −8% ❌ subestima |
| **C.2025** | OC filter (F25+Sp25) | Lead=10,743 DP=39 | recomendado (sin PBI ref) |
| C.2024 | sin diferencia (piloto) | 21 leads | — |

**Por qué OC es correcto para TxState (vs Mkt Digital correcto para AState F26):**
TxState PBI incluye leads Esfuerzo Campus + Llamada entrada (Mkt Orgánico) en su cuenta.
AState F26 PBI los excluye vía Tipo de Origen = Digital. Diferente configuración por universidad.

**Nota PBI TxState "Fall 2026" = C.2026** (Fall + Spring 2026 combinados). Misma convención que en Excel.

**UTM exclusions TxState:** ninguno de los 3 (dforce, QR_Kuthy, QR_Tajonar) en ningún ciclo → sin efecto.

Para C.2025: si Valid PBI TxState F25 ≈ 2,467 → OC correcto. Si ≈ 2,442 → Mkt Digital correcto.

---

## Metodología WhatsApp extendida — CANÓNICA (jun 8, 2026)

Clasificador WhatsApp extendido (fuente correcta: export Salesforce con campo "Created By"):
1. `Origen del Prospecto` contiene 'whatsapp' o 'wapp'
2. `LeadSource` in ('CA_Facebook_Whatsapp', 'Whatsapp')
3. `utm_source` = 'CA_Facebook_Whatsapp'
4. **`Created By` = 'Ely Genjo'** ← campo clave, NO disponible en TR, solo en export SF

**IMPORTANTE:** El TR tiene `Usuario Call Center` (col[25]) ≠ `Created By` del export SF.
La diferencia es enorme: TR da solo +7 leads vía col[25], pero el export con Created By real
da +376 leads nuevos para AState C.2026 y +103 para TxState C.2026.

**Para recalcular WhatsApp C.2026:** usar el export SF (Todo_losleads_con_las_6_OC.xls)
para identificar los Lead IDs, luego join con TR (primeros 15 chars del ID de 18) para
obtener las etapas profundas (Asistido, AdmFee, ITEP, DP).

**Cifras CANÓNICAS C.2026 (aplicadas en HTMLs jun 8, 2026):**
- AState: Lead=942, Validado=867, Perfilado=442, Citado=391, Asistido=200, AdmFee=50, ITEP=45, DP=31
- TxState: Lead=276, Validado=234, Perfilado=122, Citado=112, Asistido=47, AdmFee=6, ITEP=4, DP=1

**Ely Genjo:** agente que crea leads WA directamente en SF (Created By).
En el TR, col[39] = "Validado por Genjo" / "Perfilado por Genjo" (2,560 validaciones totales)
pero estos NO son equivalentes al "Created By" del export — no usar col[39] para clasificar WA.

---

## Estado (jun 8, 2026) — ACTUALIZACIÓN FINAL
✅ **TR ÚNICO:** `con_2027_2.xlsx` (77,933 filas — incluye Fall/Spring 2027)
✅ **WhatsApp C.2026 metodología extendida aplicada** — AState 565→942, TxState 173→276
   Fuente: `Todo_losleads_con_las_6_OC.xls` (export SF con Created By real)
   Join con TR por Lead ID (15 chars) para etapas profundas
✅ **Todos los canales recalculados** desde TR + 6 OC filter + cutoff 31-may
✅ Los 3 HTMLs actualizados y publicados GitHub Pages (commit 976fe3b):
   - cpl_etapas.html: CPL totales recalculados + obs. text actualizado
   - funneles_ciclos.html: todos los canales C.2026 + C.2025 recalculados
   - canal_rentabilidad.html: delta heatmap con datos consistentes; WA extendido
⏳ Pendiente: Separar leads Court Avenue vs Tribalo por utm_id (ver nota Tribalo abajo)

## ⚠️ NOTA INTERNA — Tribalo (no incluir en presentación)

El reporte de Power BI incluye leads de DOS agencias: **Court Avenue** y **Tribalo**.
- Court Avenue se identifica por utm_id con sus campañas propias
- Tribalo se identifica por `utm_id` conteniendo "tribalo" (o similar)
- **Problema:** las inversiones registradas en `Inversion Universidades_24-25-26.xlsx` corresponden SOLO a Court Avenue. Los CPL actuales mezclan leads de ambas agencias pero solo reflejan la inversión de una.
- **Impacto:** CPL subestimado porque el denominador (leads) incluye trabajo de Tribalo que no tiene inversión asignada en nuestros archivos.
- **Acción pendiente:** Solicitar inversión de Tribalo por ciclo, o filtrar TR excluyendo utm_id=tribalo para calcular CPL limpio de Court Avenue únicamente.
- **Nota:** No corregir esto en los HTMLs de presentación hasta tener claridad con el cliente.

## Inversión real por canal — C.2026 (fuente: Datorama granular, jun 8, 2026)
AState: WA=$1,423k · Meta=$5,108k · Google=$3,055k · Total=$9,585k (v4 ref=$12,923k)
TxState: WA=$742k · Meta=$2,583k · Google=$882k · Total=$4,207k (v4 ref=$6,306k)
Datorama cubre campañas específicas; v4 puede incluir canales adicionales o fees de agencia.

## Personas
- Cliente: Arkansas State University + Texas State University
- Enrique Rocha: enrique@ownmedia.com.mx / enrique.rocha@courtavenue.com
