---
name: Elisia Pendientes Salesforce + Estado Formularios
description: CampaignIds pendientes + estado actual de formularios Becas Alsea y Becas Fundaju en elisia.mx
type: project
originSessionId: bf3740a6-8fb2-4e63-a93d-b7cbc331a347
---
## Pendiente: CampaignIds Salesforce

Becas Alsea y Becas Fundaju usan temporalmente el CampaignId de Open Day (`701Pe00000csKQVIA2`).

**Why:** Aún no se han creado las campañas en Salesforce para estas dos becas.

**How to apply:** Cuando el usuario tenga los IDs, actualizar en `form-sports-plus.php` en SFTP (35.236.40.86, puerto 55000):
- Becas Alsea → condición `$pagina == "becas-alsea"` → cambiar CampaignId
- Becas Fundaju → condición `$pagina == "becas-fundaju"` → cambiar CampaignId
- Actualmente ambos usan la misma condición combinada — separarlos cuando tengan IDs distintos

---

## Estado actual de formularios (2026-05-29)

**Servidor:** Closte SFTP `35.236.40.86` puerto `55000`, usuario `67eca922c1ac1810207eb78d`
**Ruta tema:** `public_html/wp-content/themes/hello-theme-child-master/`

### Shortcodes registrados (functions.php)
- `[elementor_form_sports]` → `form-sports-plus.php` (activo en páginas Elementor, mantener)
- `[elementor_form_sports_plus]` → `form-sports-plus.php` (nuevo alias con nombre concordante, agregado 2026-05-29)
- `[elementor_form_becas_alsea]` → `form-Becas-Alsea.php` (registrado, no en uso activo)

### Fixes aplicados en style.css (2026-05-29)
- Versión del stylesheet cambiada de `'1.0.0'` hardcodeado a `filemtime()` — auto-invalida caché en cada cambio
- `overflow:hidden` en `.elementor-element-cf0101d` en mobile (≤767px) — corrige scroll horizontal por márgenes negativos del form wrapper
- `padding-left/right: 20px` en páginas 1182 y 1197 en mobile — separación lateral
- `margin-bottom: 40px` en botón SEND en mobile — separación del footer

### Páginas
| Página | ID | URL |
|--------|-----|-----|
| Becas Alsea | 1182 | /becas-alsea/ |
| Becas Fundaju | 1197 | /becas-fundaju/ |
| Open Day | 1072 | /formulario-open-day-elisia/ |

### Documentación completa de cambios
`/Users/erocha/Library/CloudStorage/GoogleDrive-enrique@dstudio.mx/Shared drives/COURT AVENUE /ARKANSAS STATE UNIVERSITY/DESARROLLO/FORMULARIOS/elisia-becas-alsea-cambios-2026-05-28.md`
