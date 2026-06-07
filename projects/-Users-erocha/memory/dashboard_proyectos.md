---
name: Dashboard de Proyectos Activos
description: Estado visual de todos los proyectos activos — status, última tarea y acción inmediata. Actualizar al avanzar en cada proyecto.
type: project
originSessionId: 8d238620-4970-4d63-886f-e4079ab66905
---
> Actualizado: 2026-05-29

## Leyenda
🟢 En orden · 🟡 En progreso · 🔴 Urgente/roto · ⚠️ Bloqueado esperando externo

---

## Dashboard

| # | Proyecto | Estado | Última tarea | Acción inmediata |
|---|----------|:------:|--------------|-----------------|
| 1 | **GENJO** Lead validation AState+TxState | 🟡 | Comparativo MASTER vs TRACK May 2026 (37,494 rows, Power BI) | Actualizar 87 leads de mayo pendientes en MASTER |
| 2 | **CMAGAZINE** WordPress + Closte | 🟡 | Migración WP Engine → Closte completada (abr 2026) | Redirect cmagazine.us → magazinec.com; botón SUBSCRIBE en header |
| 3 | **CJ Podcast** Conciencia Jurídica ElevenLabs | 🟢 | Excel actualizado: 45 filas Vols I–IV marcadas ✅ (may 29, 2026) | — Todos los volúmenes publicados y marcados |
| 4 | **Elisia** Formularios + Salesforce | ⚠️ | CSS móvil + shortcodes formularios resueltos (may 29, 2026) | Obtener CampaignIds Salesforce para Becas Alsea y Becas Fundaju |
| 5 | **Collins Pearls** Landing estática | 🟡 | Landing v4 completa: canvas caustics + burbujas, 5 secciones | Decidir hosting: Netlify o FTP directo a collinspearls.com |
| 6 | **Excel .xlsm** Feedback metodología | 🟢 | Patrón `ws['V18']=valor` verificado y documentado | — |
| 7 | **Cuentas Claude** Referencia cuentas | 🟢 | Cuentas enrique@ownmedia.com.mx / enrique@dstudio.mx documentadas | — |

---

## Detalle por proyecto

### 1. GENJO 🟡
- **Bloqueador:** 87 leads de mayo aún sin sincronizar en MASTER desde TRACK
- **Próximo:** Actualizar archivos FTP mensuales con datos de mayo 2026
- **Archivo clave:** `GENJO_Comparativo_MASTER_vs_TRACK_May2026.xlsx`

### 2. CMAGAZINE 🟡
- **Pendientes:** Redirect cmagazine.us → magazinec.com · SUBSCRIBE button (Top Bar widget vacío) · Verificar forms y links internos · Limpiar caché Closte
- **Activo también:** Landing Moncler (mayo 2026) en desarrollo con contraparte de diseño

### 3. CJ Podcast 🟢
- **Todos los volúmenes publicados (I–XII):** Excel actualizado may 29, 2026
- 45 filas en Vols I–IV tenían W=False → actualizadas a True (Spotify flag)
- Excel OneDrive + copia Google Drive sincronizados

### 4. Elisia ⚠️
- **Bloqueador:** CampaignIds Salesforce para Becas Alsea y Becas Fundaju no creados
- **En uso temporal:** Ambas becas usan CampaignId de Open Day (`701Pe00000csKQVIA2`)
- **Archivo a editar cuando lleguen IDs:** `form-sports-plus.php` en SFTP `35.236.40.86:55000`

### 5. Collins Pearls 🟡
- **Archivo activo:** `/tmp/collins_pearls.html` · `~/Desktop/Collins_Pearls_v4.html`
- **Pendiente:** Decisión de deployment + SEO files (`llms.txt`, `robots.txt`, `sitemap.xml`)

---

## Créditos por Agente

> Consultado: 2026-05-29 · Fuente: API en tiempo real

| Agente | Plan | Usado | Disponible | Total | Reset |
|--------|------|------:|----------:|------:|-------|
| **ElevenLabs** (CJ Podcast) | Scale | 1,167,490 chars (19.2%) | 4,923,949 chars (80.8%) | 6,091,439 | 8 jun 2026 · $990 USD |
