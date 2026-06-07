---
name: EEH Planeación 2027
description: Excel CPL por canal AState+TxState. _v4.xlsx activo con WhatsApp corregido. Arquitectura Frankenstein documentada. TxState pendiente.
type: project
originSessionId: 8d238620-4970-4d63-886f-e4079ab66905
---
Proyecto de planeación 2027 para Arkansas State University + Texas State University vía Court Avenue. Incluye dos entregables: (1) PPTX ejecutivo de funnel/CPL, (2) Excel de Presupuestos con tabla de leads por canal y CPL por etapa.

**Why:** Presentación ejecutiva al cliente con análisis de funnel comparativo 2024–25 vs 2025–26, costo por lead (CPL) por canal y etapa.

**How to apply:** Al retomar, ir directo al Excel _v4. WhatsApp corregido en _v4. Metodología completa en FUENTES_Y_METODOLOGIA.md. Próximo paso: TxState.

---

## Archivos clave

| Archivo | Ruta | Descripción |
|---------|------|-------------|
| Excel CPL v4 | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/...Copia_v4.xlsx` | **ACTIVO** — WhatsApp corregido en las 3 filas WA + AGG + TOTAL PAID |
| Excel CPL v3 | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/...Copia_v3.xlsx` | Versión anterior — Track Record completo, WhatsApp sub-contado |
| Documentación | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/FUENTES_Y_METODOLOGIA.md` | Manual completo de fuentes, clasificadores, caveats y versiones |
| Track Record master | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/Track_record_master.xlsx` | 68,070 filas, Mkt Digital. Base para Google/Meta/TikTok/Web/Mktpl |
| Leads report | `~/Downloads/sorry_erasure.xls` | 74,706 filas ago2023–jun2026. Fuente WhatsApp upper funnel |
| Oportunidades | `~/Downloads/Oportunidades-Aha.xls` | 14,082 filas. Fuente WhatsApp lower funnel (Asistido→DP) vía join |
| Scripts patch | `~/.claude/jobs/df353a38/patch_whatsapp.py` | ZIP surgery que escribió _v4.xlsx |
| EEH PPTX final | `OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/EEH_final_31may2026.pptx` | Presentación 26 slides — aprobada may 31 |
| Scripts patch | `~/.claude/jobs/df353a38/patch_fallspring.py` | ZIP surgery para editar sheet2.xml de AState |

---

## Lógica de cómputo (CRÍTICA — no cambiar sin confirmar)

### Ciclos
- C.2024 = Fall 2024 + Spring 2024, Created Date ≤ 2024-05-31
- C.2025 = Fall 2025 + Spring 2025, Created Date ≤ 2025-05-31
- C.2026 = Fall 2026 + Spring 2026, Created Date ≤ 2026-05-31
- Las etapas (Validado, DP, etc.) también filtradas por su fecha de cambio ≤ cutoff del ciclo
- **Nota:** Power BI llama "Spring 2026" al ciclo completo 2025-26 (Fall+Spring juntos)

### Clasificador de canal (Origen Conjunto → canal)
```python
def norm_channel(origen, utm):
    if origen == 'Página Web Grupal': return 'Web'
    if origen in ('Marketplace Grupal','MailChimp Grupal'): return 'Marketplaces'
    if origen == 'Digital y Redes Grupal':
        if not utm: return 'Meta'
        s = str(utm).lower().strip()
        if any(x in s for x in ('whatsapp','whats','wapp')): return 'WhatsApp'
        if any(x in s for x in ('tiktok','tk')): return 'TikTok'
        if any(x in s for x in ('google','youtube','sem','pmax','gdn','display')): return 'Google'
        return 'Meta'
    return None
```

### Estructura de filas en ASTATE_CPL (sheet2.xml)
| Ciclo | Agg | Google | Meta | WhatsApp | TikTok | Web | Mktpl | TOTAL |
|-------|-----|--------|------|----------|--------|-----|-------|-------|
| C.2024 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
| C.2025 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 |
| C.2026 | 27 | 28 | 29 | 30 | 31 | 32 | 33 | 34 |

- **Columnas de etapas:** R(Lead), T(Valid), V(Perf), X(Cit), Z(Asist), AB(AdmFee), AD(ITEP), AF(DP)
- **Fila AGG:** suma todas las channels incluyendo Web
- **Fila TOTAL:** solo canales pagados (Google+Meta+WhatsApp+TikTok+Marketplaces), SIN Web. Usada para CPL
- **Web:** lleva conteos de etapas pero NO CPL — excluida del TOTAL

---

## Datos AState verificados (_v3.xlsx = Track Record, ALL CONSISTENT ✓)

### C.2024 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | Datos |
|-------|-------|
| Google | 267, 102, 41, 41, 23, 3, 2, 2 |
| Meta | 4120, 2406, 603, 577, 296, 74, 64, 38 |
| WhatsApp | 0, 0, 0, 0, 0, 0, 0, 0 |
| TikTok | 344, 148, 45, 46, 10, 1, 1, 0 |
| Web | 3007, 1798, 734, 722, 493, 178, 156, 115 |
| Marketplaces | 84, 35, 18, 18, 16, 5, 4, 3 |
| **AGG** | **7822, 4489, 1441, 1404, 838, 261, 227, 158** |
| **TOTAL PAID** | **4815, 2691, 707, 682, 345, 83, 71, 43** |

### C.2025 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | Datos |
|-------|-------|
| Google | 30, 20, 8, 8, 5, 3, 3, 1 |
| Meta | 4793, 2314, 890, 873, 409, 102, 95, 68 |
| WhatsApp | 172, 148, 35, 36, 22, 5, 6, 5 |
| TikTok | 6, 5, 3, 3, 0, 0, 0, 0 |
| Web | 16355, 3477, 1204, 1187, 662, 193, 180, 123 |
| Marketplaces | 16, 9, 9, 7, 5, 0, 0, 0 |
| **AGG** | **21372, 5973, 2149, 2114, 1103, 303, 284, 197** |
| **TOTAL PAID** | **5017, 2496, 945, 927, 441, 110, 104, 74** |

### C.2026 [Lead, Valid, Perf, Cit, Asist, AdmFee, ITEP, DP]
| Canal | Datos |
|-------|-------|
| Google | 24, 19, 13, 9, 7, 1, 1, 1 |
| Meta | 6617, 2698, 936, 785, 421, 76, 60, 33 |
| WhatsApp | 20, 20, 18, 18, 13, 4, 4, 4 |
| TikTok | 61, 31, 10, 9, 4, 0, 0, 0 |
| Web | 8437, 4025, 1327, 1186, 763, 227, 189, 142 |
| Marketplaces | 3, 2, 1, 1, 0, 0, 0, 0 |
| **AGG** | **15162, 6795, 2305, 2008, 1208, 308, 254, 180** |
| **TOTAL PAID** | **6725, 2770, 978, 822, 445, 81, 65, 38** |

**Validación C.2026 vs Power BI:** Lead −0.3%, etapas tardías 0% de diferencia ✓

---

## Técnica de edición: ZIP surgery
- NUNCA guardar con openpyxl.save() — corrompe charts/styles
- Editar xl/worksheets/sheet2.xml con lxml.etree dentro del ZIP
- Siempre eliminar xl/calcChain.xml para forzar recálculo en Excel
- Script base en `~/.claude/jobs/df353a38/patch_fallspring.py`

---

## Estado (junio 5, 2026)
🟢 AState ASTATE_CPL — _v4.xlsx con WhatsApp corregido. Metodología en FUENTES_Y_METODOLOGIA.md
⚠️ **WhatsApp lower funnel** C.2024 0% join, C.2025 16% join — valores estimados por opp utm
⏳ **Pendiente:** TxState — misma lógica, misma estructura de hoja, sheet a identificar
⏳ **Pendiente:** Ajustar Meta (restar delta WhatsApp que estaba mal contado en TR)

## Arquitectura Frankenstein (tres fuentes)
| Datos | Fuente | Canales |
|-------|--------|---------|
| Google/Meta/TikTok/Web/Mktpl — todas etapas | Track Record master | todos |
| WhatsApp Lead/Valid/Perf/Cit | sorry_erasure.xls (Origen Conjunto + utm) | WA |
| WhatsApp Asistido/AdmFee/DP | Oportunidades-Aha.xls (join ID SF Lead + utm fallback) | WA |
| ITEP WhatsApp | Fijado en 0 — no disponible en nuevas fuentes | WA |

## Personas
- Cliente: Arkansas State University + Texas State University
- Enrique Rocha: enrique@ownmedia.com.mx / enrique.rocha@courtavenue.com
