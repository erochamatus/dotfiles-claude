---
name: EEH Planeación 2027
description: Excel CPL por canal AState+TxState. Track Record completo para C.2024/C.2025/C.2026. SF leads base maestra disponible. Funneles visuales generados.
type: project
originSessionId: 8d238620-4970-4d63-886f-e4079ab66905
---
Proyecto de planeación 2027 para Arkansas State University + Texas State University vía Court Avenue. Incluye dos entregables: (1) PPTX ejecutivo de funnel/CPL, (2) Excel de Presupuestos con tabla de leads por canal y CPL por etapa.

**Why:** Presentación ejecutiva al cliente con análisis de funnel comparativo 2024–25 vs 2025–26, costo por lead (CPL) por canal y etapa.

**How to apply:** Al retomar, ir directo al Excel _v4. WhatsApp corregido en _v4. Metodología completa en FUENTES_Y_METODOLOGIA.md. Track Record ahora completo para los 3 ciclos.

---

## Archivos clave

| Archivo | Ruta | Descripción |
|---------|------|-------------|
| Excel CPL v4 | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/...Copia_v4.xlsx` | **ACTIVO** — WhatsApp corregido en las 3 filas WA + AGG + TOTAL PAID |
| Excel CPL v3 | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/...Copia_v3.xlsx` | Versión anterior — Track Record completo, WhatsApp sub-contado |
| Documentación | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/FUENTES_Y_METODOLOGIA.md` | Manual completo de fuentes, clasificadores, caveats y versiones |
| SF Leads base | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/SF_leads_base_maestra.csv` | 84,792 filas · AState 62,097 · TxState 22,695 · todos los ciclos |
| Funnel visual | `~/.claude/jobs/a9550654/tmp/funnel_comparativo_astate.html` | HTML con tabs AState/TxState, SF vs v4 por canal y ciclo |
| EEH PPTX final | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/EEH_final_31may2026.pptx` | Presentación 26 slides — aprobada may 31 |
| Scripts patch | `~/.claude/jobs/df353a38/patch_whatsapp.py` | ZIP surgery que escribió _v4.xlsx |
| Scripts patch | `~/.claude/jobs/df353a38/patch_fallspring.py` | ZIP surgery para editar sheet2.xml de AState |

---

## Track Record — archivos fuente (todos en ~/Downloads)

### C.2024 (Fall 2024 + Spring 2024, cutoff 2024-05-31)
| Archivo | Filas | Contenido |
|---------|-------|-----------|
| `ciclo-24-full.csv` | 11,736 ✅ | AState 11,715 · TxState 21 (test irrelevante) |

### C.2025 (Fall 2025 + Spring 2025, cutoff 2025-05-31)
| Archivo | Filas | Contenido |
|---------|-------|-----------|
| `Track_Record_Ak_2024-25.xlsx` | 18,425 ✅ | AState · Fall 2025 (12,440) + Spring 2025 (5,984) |
| `Track_Record_Tx_2024-25.xlsx` | 9,212 ✅ | TxState · Fall 2025 (9,137) + Spring 2025 (74) |

### C.2026 (Fall 2026 + Spring 2026, cutoff 2026-05-31)
| Archivo | Filas | Contenido |
|---------|-------|-----------|
| `Track_Record_Ak_2025-26.xlsx` | 11,261 ✅ | AState · Fall 2026 (7,827) + Spring 2026 (3,433) |
| `Track_Record_Tx_2025-26.xlsx` | 7,618 ✅ | TxState · Fall 2026 (4,474) + Spring 2026 (3,143) |
| `TR_C2026_AState_TxState.csv` | 22,411 ✅ | AState+TxState combinado (OneDrive PLANEACION 2027) |
| `25_new.csv` | 22,872 ✅ | C.2026 completo (mismo ciclo, export más reciente) |

### Archivos descartados
| Archivo | Razón |
|---------|-------|
| `ciclo-25.csv` | 30,000 filas — CORTADO por límite Salesforce |
| `Spring_25_all.xlsx` / `fall_25_all.xlsx` | Formato Summary/Matrix — solo 1 columna (Ciclo), sin datos |
| `26_all.xlsx` / `24_all.xlsx` / `25_all.xlsx` | Mismo problema: formato Summary, sin datos reales |

---

## Convención de nombrado (CRÍTICA)
Salesforce usa el año de INGRESO del estudiante en el campo Ciclo:
- "Fall 2025" = estudiantes que ingresan en agosto 2025 (reclutados 2024-25) → **C.2025**
- "Spring 2025" = estudiantes que ingresan en enero 2025 → **C.2025**
- "Fall 2026" = estudiantes que ingresan en agosto 2026 (reclutados 2025-26) → **C.2026**
- Los archivos nombrados "2024-25" = Salesforce Fall 2025 + Spring 2025 = **C.2025**
- Los archivos nombrados "2025-26" = Salesforce Fall 2026 + Spring 2026 = **C.2026**

---

## Lógica de cómputo (CRÍTICA — no cambiar sin confirmar)

### Ciclos
- C.2024 = Fall 2024 + Spring 2024, Created Date ≤ 2024-05-31
- C.2025 = Fall 2025 + Spring 2025, Created Date ≤ 2025-05-31
- C.2026 = Fall 2026 + Spring 2026, Created Date ≤ 2026-05-31
- Las etapas (Validado, DP, etc.) también filtradas por su fecha de cambio ≤ cutoff del ciclo

### Clasificador de canal SF (versión definitiva)
```python
def norm_channel_sf(oc, op, us):
    """oc=Origen Conjunto, op=Origen del Prospecto, us=utm_source"""
    op_l = op.lower().strip(); us_l = us.lower().strip()
    # WhatsApp override PRIMERO — antes de Origen Conjunto
    if any(x in op_l for x in ('whatsapp','wapp')): return 'WhatsApp'
    if oc == 'Página Web Grupal': return 'Web'
    if oc in ('Marketplace Grupal','MailChimp Grupal'): return 'Marketplaces'
    if oc == 'Digital y Redes Grupal':
        if 'tiktok' in op_l or 'tiktok' in us_l: return 'TikTok'
        if any(x in us_l for x in ('google','pmax','gdn','youtube','google_search',
                                    'google_video','google_discovery','google_ads')): return 'Google'
        return 'Meta'
    return None
```

### Columnas SF_leads_base_maestra.csv (34 cols)
| Idx | Campo | Uso |
|-----|-------|-----|
| 0 | Clasificación | AState / TxState |
| 1 | Lead ID | Join con oportunidades |
| 7 | Company | AState / TxState |
| 8 | Lead Status | — |
| 9 | Origen del Prospecto | WhatsApp override (CA_Facebook_Whatsapp / Whatsapp) |
| 10 | Origen Conjunto | Canal principal |
| 11 | Lead Source | — |
| 13 | utm_source | Google/TikTok discriminador |
| 18 | Fecha Creación F | Filtro cutoff ciclo |
| 19 | Cambio a Validado | Etapa Valid |
| 20 | Cambió a perfilado | Etapa Perf (histórico incompleto) |
| 21 | Cambio a Citado | Etapa Cit |
| 30 | Cambio a Asistió | Etapa Asist |
| 31 | Fecha Admission Fee | Etapa AdmFee |
| 32 | Fecha ITEP | Etapa ITEP |
| 33 | Fecha Pago Down Payment | Etapa DP |

### Join oportunidades (lower funnel WhatsApp)
- Archivo: `~/Downloads/leads_oportunidades_2.xls` (HTML disfrazado de .xls, parsear con HTMLParser)
- 13,699 filas · join por Lead ID → aporta Asistió/AdmFee/ITEP/DP para WA
- 563 leads WhatsApp con datos lower funnel

### Estructura de filas en ASTATE_CPL (sheet2.xml)
| Ciclo | Agg | Google | Meta | WhatsApp | TikTok | Web | Mktpl | TOTAL |
|-------|-----|--------|------|----------|--------|-----|-------|-------|
| C.2024 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
| C.2025 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 |
| C.2026 | 27 | 28 | 29 | 30 | 31 | 32 | 33 | 34 |

- **Columnas de etapas:** R(Lead), T(Valid), V(Perf), X(Cit), Z(Asist), AB(AdmFee), AD(ITEP), AF(DP)
- **Fila AGG:** suma todas las channels incluyendo Web
- **Fila TOTAL:** solo canales pagados (Google+Meta+WhatsApp+TikTok+Marketplaces), SIN Web
- **Técnica edición:** ZIP surgery con lxml.etree — NUNCA openpyxl.save()

---

## Datos funnel SF (HTML artifact generado, jun 7 2026)

### AState C.2024 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | SF |
|-------|-----|
| Google | 0, 0, 0, 0, 0, 0, 0, 0 (sin utm 2024) |
| Meta | 2613, 1277, 149, 465, 279, 61, 52, 26 |
| WhatsApp | 928, 863, 50, 93, 41, 1, 1, 0 |
| TikTok | 0, 0, 0, 0, 0, 0, 0, 0 (sin utm 2024) |
| Web | 2497, 1425, 130, 640, 437, 131, 113, 70 |
| Marketplaces | 46, 44, 0, 44, 43, 8, 7, 4 |

### AState C.2025 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | SF |
|-------|-----|
| Meta | 3164, 1173, 320, 583, 288, 68, 62, 45 |
| WhatsApp | 1847, 1351, 219, 405, 209, 45, 42, 27 |
| Web | 15873, 3136, 549, 1088, 619, 187, 172, 118 |
| TOTAL PAID SF | 5047 vs v4 5017 = +30 (+0.6%) ✅ |

### AState C.2026 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | SF |
|-------|-----|
| Meta | 6331, 2493, 605, 660, 351, 52, 41, 21 |
| WhatsApp | 541, 510, 201, 220, 115, 26, 26, 14 |
| Web | 8003, 3623, 844, 923, 665, 187, 156, 115 |
| TOTAL PAID SF | 6947 vs v4 6725 = +222 (+3.3%) ✅ |

### TxState C.2025 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | SF |
|-------|-----|
| Meta | 2789, 907, 206, 311, 118, 16, 14, 9 |
| WhatsApp | 1086, 704, 92, 125, 54, 9, 6, 6 |
| Web | 5316, 821, 146, 226, 108, 24, 22, 15 |

### TxState C.2026 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | SF |
|-------|-----|
| Meta | 6089, 2288, 305, 345, 114, 11, 11, 8 |
| WhatsApp | 171, 145, 72, 72, 31, 6, 5, 3 |
| Web | 1333, 674, 201, 206, 145, 38, 29, 20 |

---

## Caveats importantes
- **C.2024 Google/TikTok:** SF no recupera (sin utm en 2024). v4 tiene 267 Google + 344 TikTok de Datorama
- **Perfilado (Perf):** SF sistemáticamente menor — campo histórico no capturado
- **Web C.2025/2026:** SF menor porque leads WA reclasificados de Web → WhatsApp
- **TxState C.2024:** Solo 10 leads — producto en early stage, irrelevante

---

## Estado (jun 7, 2026)
✅ Track Record **completo** para C.2024, C.2025 y C.2026 (AState + TxState)
✅ SF leads base maestra disponible (84,792 filas)
✅ Funnel visual HTML generado con comparativo SF vs v4
⏳ **Pendiente:** Recalcular funneles con Track Record nuevo (Ak/Tx 2024-25 y 2025-26)
⏳ **Pendiente:** Actualizar v4.xlsx con datos SF (TxState + WhatsApp corregido)
⏳ **Pendiente:** Ajustar Meta en v4 (restar delta WhatsApp mal contado en TR anterior)

## Personas
- Cliente: Arkansas State University + Texas State University
- Enrique Rocha: enrique@ownmedia.com.mx / enrique.rocha@courtavenue.com
