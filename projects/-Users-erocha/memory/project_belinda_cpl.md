---
name: project-belinda-cpl
description: "Reportes CPL de Nuevo Ingreso AState y TxState — metodología completa, flujo reproducible por ciclo, archivos en ~/BELINDA"
metadata: 
  node_type: memory
  type: project
  originSessionId: a9550654-8570-4315-acbd-1c5138cd4fd1
---

Reportes de Costo por Lead (CPL) para AState y TxState. Archivos entregables en:
`~/Library/CloudStorage/OneDrive-Personal/COURT AVENUE/2026/BELINDA/`

**Why:** Análisis de eficiencia de inversión publicitaria (Datorama) vs NI (Nuevo Ingreso = pago Down Payment confirmado).

**How to apply:** Cuando el usuario mencione CPL, NI, los_197, los_26, Belinda, AState/TxState inversión, Datorama o quiera replicar el análisis para otro ciclo.

---

## RUTAS DE ARCHIVOS

### Entregables
```
~/Library/CloudStorage/OneDrive-Personal/COURT AVENUE/2026/BELINDA/
  ├── los_197_de PBI.xlsx          ← AState C.2026 (197 NI)
  └── los_26_TxState_NI.xlsx       ← TxState C.2026 (26 NI)
```

### Fuente NI (Salesforce/TR)
```
~/Library/CloudStorage/OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/
  └── TR_C2026_AState_TxState.csv  ← 22,411 rows, 61 cols; master de leads
      Cols clave: Universidad_Origen, Ciclo, Created Date, Nombre, Apellidos,
                  Origen Conjunto, Origen del Prospecto, utm_source, utm_campaign,
                  Fecha Pago Down Payment

~/Downloads/
  └── Los 23.xlsx                  ← 26 NI TxState con Fecha Pago (nombre engañoso)
```

### Datorama — Inversiones
```
~/Library/CloudStorage/OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/INVERSIONES/DATORAMA/
  ├── ASTATE/
  │   ├── DATORAMA_ASTATE_por_Plataforma_2025.xlsx   ← Ene-Dic 2025 (consolidado)
  │   ├── AK_Data por Plataforma por dia.xlsx         ← incluye Ene-2026
  │   ├── AK-Data-Feb.xlsx / AK-Data-Marzo.xlsx
  │   ├── AK-Data-Abril.xlsx / AK-Data-Mayo.xlsx
  └── TXST/
      ├── tx_oct_25.xlsx / tx_nov_25.xlsx / tx_dic_25.xlsx
      │   (estructura: row5=headers, col2=Medio TXS, col11=COSTO)
      ├── TX-Data-Feb.xlsx / TX-Data-Marzo.xlsx
      ├── TX-Data-Abril.xlsx / TX-Data-Mayo.xlsx
      │   (estructura: row5=headers, col3=Platform, col6=Cost)
      └── TX_Data por Plataforma por dia.xlsx

~/Library/CloudStorage/OneDrive-Personal/COURT AVENUE/2026/PLANEACION 2027/
  └── Updated 23 June - Presupuestos Marketing Ago 2023 a Julio 2025 - Copia_v4.xlsx
      Sheet TXST_CPL: contiene Ago-25 y Sep-25 Datorama para TxState
      Sheet ASTATE_CPL: contiene datos AState por ciclo
```

### Script de referencia
```
~/Library/CloudStorage/OneDrive-Personal/.claude/jobs/a9550654/tmp/rebuild_los26.py
```

---

## FLUJO COMPLETO (reproducible por ciclo)

### Paso 1 — Obtener lista de NI
- **Fuente:** archivo CSV de Salesforce/TR: `PLANEACION 2027/TR_C2026_AState_TxState.csv`
- **Filtros para C.2026:** Ciclo = Fall 2026 o Spring 2026 | Fecha Pago Down Payment ≤ 31/May/YYYY
- Para ciclos anteriores ajustar el rango de Ciclo y fecha corte
- Columnas clave: Nombre, Apellidos, Origen Conjunto, Origen del Prospecto, utm_source, utm_campaign, Fecha Pago Down Payment, Universidad_Origen

### Paso 2 — Clasificar leads por canal
Reglas de clasificación (orden de prioridad):
| Condición (Origen del Prospecto o utm_source) | Canal |
|----------------------------------------------|-------|
| OP = "Whatsapp" o "CA_Facebook_Whatsapp" | WhatsApp → cuenta como **Meta** |
| OP contiene "facebook", "Digital", "facebook_ads", "instagram" | **Meta** FB/IG |
| OP contiene "google_pmax", "google", "sem" | **Google** |
| OP contiene "Web", "Esfuerzo Campus", "web2020" | **Website** |

Totales C.2026:
- **AState:** 197 NI → Website=127→69*, Meta=51, Google=19→77* (*post-CN)
- **TxState:** 26 NI → Website=13→8*, Meta=12, Google=1→6* (*post-CN)

### Paso 3 — Cross Network redistribution (Website → Google)
- Los leads CN son captados por Meta/Display pero su inversión aparece en Google en Datorama
- Tasa aplicada: **AState = 45.7%** (58/127) | **TxState = 36%** (dato provisto por cliente)
- CN_total = round(Web_NI × tasa)
- Distribución mensual: proporcional al Web NI de cada mes (método largest-remainder)
- Resultado: restar CN de Web, sumar CN a Google mes a mes

### Paso 4 — Obtener inversión Datorama por mes y canal
**Fuentes TxState C.2026:**
- Ago-25 / Sep-25: sheet TXST_CPL del v4 (`PLANEACION 2027/Updated 23 June - Presupuestos...v4.xlsx`)
- Oct-25 a May-26: archivos individuales en `INVERSIONES/DATORAMA/TXST/`
  - Oct/Nov/Dic: estructura row5=headers, col2=Medio, col11=COSTO (col12 para Dic por columna extra)
  - 2026: estructura row5=headers, col3=Platform, col6=Cost

**Fuentes AState C.2026:**
- Archivo consolidado 2025: `INVERSIONES/DATORAMA/ASTATE/DATORAMA_ASTATE_por_Plataforma_2025.xlsx`
- Archivos 2026 por mes: AK-Data-Feb/Marzo/Abril/Mayo.xlsx + consolidado para Enero

**Clasificación de canal en Datorama:**
- Platform = "Whatsapp" o campaign contiene "click to whatsapp" → WhatsApp
- Platform = "SEM", "Pmax", "YouTube", "Google Ads" → Google
- Platform = "Facebook", "Instagram", "FB Form", "Audience", "Messenger" → Meta

### Paso 5 — Calcular inversión proporcional por mes (largest-remainder)
Para cada canal (Meta, Google) con NI:
```
inv_mes = (NI_mes / NI_total_canal) × Inv_total_canal
```
Garantiza que la suma mensual sea exactamente igual al total Datorama.
CPL por mes = inv_mes / NI_mes → siempre igual al CPL total del canal (constante por construcción).

### Paso 6 — Construir reporte Excel
Estructura del archivo (hoja NuevoIngreso):
- **R1:** Título con nombre de universidad + total NI + fecha corte (fondo azul oscuro `1F4E79`)
- **R3-R13:** DETALLE POR ORIGEN — tabla de orígenes Salesforce con su grupo de canal
- **R26-R39:** DETALLE MENSUAL — NI y costos por mes (cols A-L)
- **Cols N-R:** RESUMEN POR PLATAFORMA (R3-R8) + ANÁLISIS CPL (R10-R17)
  - ANÁLISIS CPL incluye desglose Meta = FB/IG + WhatsApp
- **R41-R42:** Nota metodológica Cross Network (fondo amarillo)
- **Gráfica de pie:** distribución NI por plataforma (anclada en N20)

Referencia de estilos (espejo los_197):
- Font: Aptos Narrow 12pt
- Título: `1F4E79` (azul oscuro) texto blanco bold 
- Sección headers: `4472C4` (azul) texto blanco bold
- Column headers: `D9E2F3` (azul claro) bold
- Filas alternas: `EBF3FA`
- Fila TOTAL: `BDD7EE`

Script de referencia: `/Users/erocha/.claude/jobs/a9550654/tmp/rebuild_los26.py`

---

## ARCHIVOS ENTREGABLES C.2026

### `los_197_de PBI.xlsx` — AState
- 197 NI | Website=69 | Meta=51 | Google=77
- Inv: Meta=$8,740,663 | Google=$7,064,644 | Total=$15,805,307
- CPL: Meta=$171,386 | Google=$91,749 | FB/IG=$210,034 | WA=$120,440
- CN: 58 leads Web→Google (45.7%) | nota en R52-R53

### `los_26_TxState_NI.xlsx` — TxState
- 26 NI | Website=8 | Meta=12 | Google=6
- Inv: Meta=$4,275,791 | Google=$1,076,288 | Total=$5,352,079
- CPL: Meta=$356,316 | Google=$179,381 | FB/IG=$450,576 | WA=$73,535 | Total=$205,849
- CN: 5 leads Web→Google (36%) | nota en R41-R42

---

## PARA EL CICLO ANTERIOR (C.2025 = Ago-2024 a Jul-2025)

El usuario quiere replicar este mismo análisis para C.2025. Pendiente definir:
1. Lista NI fuente: probablemente misma ruta CSV con filtro Ciclo = Fall 2025 / Spring 2025
2. Tasa Cross Network para cada universidad en C.2025
3. Archivos Datorama C.2025: el v4 cubre "Ago 2023 a Julio 2025" — sheet TXST_CPL y ASTATE_CPL tienen datos por ciclo
4. Fecha corte de NI (equivalente a 31/May/2026 para C.2025 sería ~31/May/2025 o final del ciclo)

**How to apply:** Cuando el usuario pida "el ciclo anterior", "C.2025" o similar, arrancar con estos mismos 6 pasos usando los filtros de C.2025.
