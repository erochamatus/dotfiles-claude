---
name: project-belinda-cpl
description: "Reportes CPL de Nuevo Ingreso AState y TxState C.2026 — archivos en ~/BELINDA, metodología Cross Network, valores Datorama definitivos"
metadata: 
  node_type: memory
  type: project
  originSessionId: a9550654-8570-4315-acbd-1c5138cd4fd1
---

Reportes de Costo por Lead (CPL) para los ciclos C.2026 de AState y TxState. Archivos en:
`~/Library/CloudStorage/OneDrive-Personal/COURT AVENUE/2026/BELINDA/`

**Why:** Análisis de eficiencia de inversión publicitaria (Datorama) vs NI (Nuevo Ingreso = pago Down Payment confirmado).

**How to apply:** Cuando el usuario mencione CPL, NI, los_197, los_26, Belinda, AState/TxState inversión o Datorama C.2026.

## Archivos

### `los_197_de PBI.xlsx`
- **197 NI AState C.2026** (Ene-2025 a May-2026)
- Hoja: NuevoIngreso
- NI por canal: Website=69, Meta=51, Google=77
- Inversiones Datorama: Meta=$8,740,663 | Google=$7,064,644 | Total=$15,805,307
- CPL: Meta=$171,386 | Google=$91,749 | FB/IG=$210,034 | WA=$120,440
- **Cross Network AState:** 58 de 127 Web leads redistribuidos a Google (45.7%)
  Website 127→69 | Google 19→77
- Tabla mensual: R28-R46 (Ene-25 a May-26 + Antes de 2025)
- Nota metodológica CN en R52-R53

### `los_26_TxState_NI.xlsx`
- **26 NI TxState C.2026** (hasta 31/May/2026, source: "Los 23.xlsx" que tiene 26 registros)
- Hoja: NuevoIngreso
- NI por canal (post-CN): Website=8, Meta=12, Google=6 | Total=26
- Inversiones Datorama: Meta=$4,275,791 | Google=$1,076,288 | Total=$5,352,079
- CPL: Meta=$356,316 | Google=$179,381 | FB/IG=$450,576 | WA=$73,535 | Total=$205,849
- **Cross Network TxState:** 5 de 13 Web leads redistribuidos a Google (36%)
  Website 13→8 | Google 1→6 | CPL Google: $1,076,288 → $179,381
- Tabla mensual: R28-R39 (Anterior a Ago-2025 a May-2026)
- RESUMEN POR PLATAFORMA: cols N (R3-R8)
- ANÁLISIS CPL: cols N (R10-R17) — incluye desglose FB/IG y WA
- Gráfica de pie: NI por plataforma (posición N20)
- Nota metodológica CN en R41-R42

## Metodología CPL
- Inversión proporcional: cada mes recibe (NI_mes/NI_total_canal) × Inversión_total_canal
- Largest-remainder garantiza que las sumas mensuales sean exactamente iguales al total Datorama
- Cross Network: leads clasificados como Website en Salesforce pero generados por inversión Google → redistribuir a Google
- Meta+WA se reportan combinados en inversión total y separados en ANÁLISIS CPL

## Fuente inversiones TxState (DATO definitivo)
- Ago-25/Sep-25: del v4 TXST_CPL (ya tenía Datorama)
- Oct-25 a May-26: archivos Datorama individuales en `INVERSIONES/DATORAMA/TXST/`
- v4 path: `PLANEACION 2027/Updated 23 June - Presupuestos Marketing Ago 2023 a Julio 2025 - Copia_v4.xlsx`
