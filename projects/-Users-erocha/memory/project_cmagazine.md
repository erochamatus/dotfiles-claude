---
name: CMAGAZINE Project Context
description: Context for CMAGAZINE web redesign — WordPress/Closte site, CSS fixes, migration, and file locations across drives
type: project
originSessionId: 83b855a8-df64-4d9d-8a8a-0f47a2842d97
---
CMAGAZINE is a magazine website redesign and migration project operated by Court Avenue / OwnMedia.

**Why:** Site needed mobile CSS fixes, PHP template cleanup, and migration from WP Engine to Closte.

**How to apply:** When user mentions CMAGAZINE, magazinec.com, cmagazine.us, Newstar theme, Closte, or magazine CSS — this is the relevant context.

## Sites
- Staging: https://cmagazine.us (hosted on Closte)
- Production: https://magazinec.com (hosted on Closte, migrated from WP Engine Apr 2026)
- Theme: Newstar (Bold Themes) + Newstar Child Theme (customized by Court Avenue)

## Infrastructure
- Hosting: Closte (IP: 35.236.40.86)
- CDN/Proxy: Cloudflare (NS: brady.ns.cloudflare.com / imani.ns.cloudflare.com)
- DNS registrar: Rackspace
- Previous host: WP Engine (site: cmagproduction) — staging still available there
- S3 bucket: magazinecwpenginesite (us-west-1) — legacy uploads from WP Engine

## File locations
- **Google Drive:** `Shared drives > COURT AVENUE > C MAG > CONTEXTO_CLAUDE`
  - Local path: `/Users/erocha/Library/CloudStorage/GoogleDrive-enrique@dstudio.mx/Shared drives/COURT AVENUE /C MAG/CONTEXTO_CLAUDE/`
- **OneDrive:** `OneDrive-Personal > Court Avenue > CMAGAZINE > CONTEXTO_CLAUDE`
  - Local path: `/Users/erocha/Library/CloudStorage/OneDrive-Personal/Court Avenue/CMAGAZINE/CONTEXTO_CLAUDE/`

## Context documents (3 .md files in CONTEXTO_CLAUDE)
- `CMAGAZINE_Chat_InstalacionClaudeCode.md` — origen de Claude Code, instalación
- `CMAGAZINE_Chat_WeeklyMasters.md` — consolidación CSVs ASUQ/TXST en masters Excel
- `CMAGAZINE_Chat_WordPressMigracion.md` — CSS fixes, PHP related-items, migración WP Engine→Closte

## Key CSS fixes applied (child theme: /Users/erocha/Desktop/Cluade-FileZila/CMAGAZINE/newstar-child/style.css)
- CSS version actual: `060326 V.3` (cambiar versión en header del file fuerza cache-bust en WordPress)
- SFTP upload: `sshpass -p 'cmqeFD@qLV6w76' sftp -P 55000 -o PreferredAuthentications=password 67c90292c1ac180cd416af65@35.236.40.86`
- Mobile spacing: `margin-top` en `.bt_bb_headline_tag` con scope por contexto (slider vs listados)
- Buttons: `.bt_bb_color_scheme_6` (slider) vs `.bt_bb_size_xsmall` (Continue Reading)
- CTA ads: `.btIsAd .bt_bb_text p:last-child` reset, CTA en `@media (min-width: 768px)`
- Related Posts images: `object-fit: cover` en `.btRelatedPostsContent`
- Slider hero mobile: `margin-top: 2rem` en `.btPostSingleItemStandard` para pill+título (scope mobile `max-width:767px`)
- ADS baseball card altura: selector CORRECTO es `.btSinglePostTemplate.btIsAd .btPostImageHolder`. El selector `[data-bt-bb-fe-atts*="ADS"]` tiene **0 matches en el frontend**.
- GIF del AD: `aspect-ratio: 1215/1890 !important` en `.btPostImageHolder` (NO height fija) — iguala la altura al editorial card automáticamente en cualquier ancho de grid. `object-fit: scale-down` en img para mostrar GIF completo. GIF nativo: 1215×1890px.
- AD card holder: `display:flex; align-items:flex-start; justify-content:center; background:#fff`
- Col-xxl-3 (AD + 4th editorial): `.bt_bb_column.col-xxl-3:has(.btSiglePostGrid.btOnlyOne) { padding-left:0; padding-right:6px }` — 294px content. La estructura 9+3 crea offset estructural de 4–6px vs PARTIES que no se puede eliminar con CSS.
- **LATEST ROW 1 gray strip fix (Jun 4 2026):** `.btSingleItemColumnInner .btPostImageHolder a { display:block; height:100% }` + `img { height:100% !important; object-fit:cover; object-position:50% 0% }`
- **AD card pill oculto (Jun 4 2026):** `.btSiglePostGrid .btIsAd .bt_bb_headline_superheadline_outside, .btIsAd .bt_bb_headline_superheadline_outside { display:none !important; visibility:hidden !important }` — regla GLOBAL (fuera de cualquier @media). Cuidado: hay un `@media (max-width: 767px)` que abre en línea ~2773 y no cierra hasta ~2900+; reglas "globales" escritas dentro de ese bloque quedan scope-adas a mobile.
- **Grid cards mobile pill→título gap (Jun 4 2026):** `margin-top: 76px` en `.btSiglePostGrid .btSinglePostContentInner header .bt_bb_headline_tag` dentro de `@media (max-width:767px)`. El pill wrapper del tema tiene `margin-bottom: -16px` en grid cards (0px en hero) — por eso 76px en grid = 60px gap visual = igual al hero.
- **LATEST ROW 1 mobile — sin tag:** Es config del builder (supertítulo no habilitado en ese widget). Fix: WordPress admin → Home page → Builder → widget LATEST ROW 1 → habilitar "Show Categories Supertitle".
- **Breakpoints tablet confirmados (Jun 4 2026):** ≤767px=mobile 1col, 768–991px=tablet hamburguesa+2col (decisión de diseño: dejar así), 992px+=desktop nav+4col. El grid del tema usa `@media screen and (max-width:991px) { flex: 0 0 50% }` en `.btColumns_4`.

## LATEST Section AD INJECTION — COMPLETADA (Jun 4 2026)

**Resultado:** El Ojai Valley Inn baseball card GIF aparece en posición 4 de LATEST ROW 1 automáticamente.

**Arquitectura crítica (confirmada con probes Jun 4 2026):**
- El archivo activo es el PADRE: `newstar/php/after_framework/section.php` — cargado por `newstar/php/after_framework.php` vía `get_template_directory()`
- `newstar-child/php/after_framework/section.php` — NUNCA se carga (código muerto, confirmado con probe wp_head)
- `newstar-child/php/section.php` — NUNCA se carga (código muerto, confirmado con probe wp_head)
- `newstar-child/functions.php` — carga solo: `inc/acf/acf.php`, `inc/theme-overrides/boldthemes_logo_override.php`, `inc/theme-overrides/boldthemes_header_headline.php`
- **Para editar PHP de secciones → SIEMPRE editar el padre**: `newstar/php/after_framework/section.php`
- **Copia local de trabajo**: `/Users/erocha/Desktop/Cluade-FileZila/CMAGAZINE/newstar-parent/php/after_framework/section.php` (727 líneas)

**Cómo funciona la inyección (WORKING Jun 4 2026):**
- LATEST ROW 1 usa `bt_bb_single_article` directamente en `bt_bb_section` (sin `bt_bb_article_container`)
- Filter activo: `bt_bb_section_output` — `bt_bb_article_container_output` no aplica a LATEST ROW 1
- Fingerprint único de LATEST ROW 1: `bt_image_lazy_load__no__` + `bt_image_format__boldthemes_large_vertical_rectangle_3x2__` (verificar ANTES del str_replace que los convierte a `--`)
- Condición adicional: `$items_to_replace === 4` + `is_front_page()` + `current_filter() === 'bt_bb_section_output'`
- Ad query usa `bt_local_exclude_ids => array()` para ignorar el global exclude (Ojai puede estar excluido de secciones anteriores)
- Después de inyección: agregar ID del ad a `$bt_global_exclude_ids` para evitar duplicados en secciones siguientes
- `btIsAd` se inyecta en el Nth div con `preg_replace_callback` + counter sobre `btSinglePostTemplate` (post str_replace de TemplateCount)
- Template del PADRE (`newstar/bold-page-builder/.../bt_bb_single_article_template.php`) NO tiene `{{ ad_class }}` — btIsAd se inyecta directamente en el HTML final, no via marker

**Ad post inyectado:** `ojai-valley-inn-baseball-card-gif` (slug), categoría "ads", aparece en posición 4 de LATEST ROW 1

## BoldThemes notas clave
- `[data-bt-bb-fe-atts*='"category_filter":"ADS"']` NO existe en el frontend — 0 matches. Solo existe en el backend builder. Para targeting de AD cards en el frontend usar `.btIsAd` o `.btSinglePostTemplate.btIsAd`.
- Inline styles del builder (`padding-right/left`) están en `.bt_bb_column`, se anulan con `:has()` + `!important`.
- `.btIsAd` es la clase más confiable para identificar cards de anuncio en el frontend.
- LATEST usa estructura `col-xxl-9 + col-xxl-3` (NO 4×col-xxl-3). PARTIES usa `btSiglePostGrid` de 4 cards en col-xxl-12. Por esto hay un offset de 6px entre el 4th card de LATEST y PARTIES — es estructural, no corregible con CSS.
- btSingleItemRowInner tiene `margin: -7.5px` en cada lado (gutter compensation del widget). btSingleItemColumnInner tiene `margin: 7.5px` para restaurar. El ancho VISIBLE real del card es btSingleItemColumnInner.

## PHP fix
- `related-items.php` — conditional rendering with `if($related_title || $related_items)`
- Location: `/wp-content/themes/newstar-child/`

## JS fix in footer.php
- naturalWidth: 0 image recovery script with cache-busting + S3 fallback

## Landings comerciales (Figma)

Flujo de trabajo con contraparte de diseño vía archivos .fig:

**Problema común: imágenes no cargan al compartir .fig**
- Causa: imágenes pegadas desde Finder o clipboard quedan como referencias temporales, no embebidas
- Fix en archivo original: `Cmd+A` → `Edit → Select All With → Image Fills` → re-subir cada imagen rota desde el Fill panel
- Fix limpio antes de compartir: `File → Export → .fig` (Figma re-empaca y embebe todo)
- Fix del lado receptor: abrir en Figma Desktop → esperar carga completa → `File → Save local copy`

**Proyectos activos:**
- Landing Moncler (mayo 2026) — en desarrollo con contraparte de diseño

---

## Pending (as of Jun 4, 2026)
- Redirect cmagazine.us → magazinec.com
- SUBSCRIBE button in header (Top Bar widget empty in Closte)
- Verify forms and internal links

## People
- Enrique Rocha: enrique.rocha@courtavenue.com / enrique@ownmedia.com.mx
