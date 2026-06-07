---
name: Conciencia Jurídica Podcast
description: Proyecto Conciencia Jurídica Podcast — pipeline de generación de audio para artículos de la revista con voces clonadas vía ElevenLabs. Rutas de archivos, voces, parámetros, flujo y estado por volumen.
type: project
originSessionId: bcc0b195-60ee-4f46-b8ea-0021ae47d11c
---
## ¿Qué es este proyecto?

Revista jurídica digital **Conciencia Jurídica** (sitio: concienciajuridica.com). Cada artículo se convierte a audio usando la voz clonada del autor real vía ElevenLabs API. Los audios se suben como episodios de podcast.

## Calendario de publicación por volumen

| Volumen | Mes de publicación | Fecha Spotify sugerida |
|---------|-------------------|------------------------|
| I | Noviembre 2023 | 2023-11-01 |
| II | Enero 2024 | 2024-01-01 |
| III | Marzo 2024 | 2024-03-01 |
| IV | Mayo 2024 | 2024-05-01 |
| V | Julio 2024 | 2024-07-01 |
| VI | Septiembre 2024 | 2024-09-01 |
| VII | Noviembre 2024 | 2024-11-01 |
| VIII | Enero 2025 | 2025-01-01 |
| IX | Marzo 2025 | 2025-03-01 |
| X | Junio 2025 | 2025-06-01 |
| XI | Noviembre 2025 | 2025-11-01 |
| XII | Mayo 2026 | 2026-05-23 |

Fuente: concienciajuridica.com/revistas-portadas/

**Why:** Ampliar el alcance del contenido jurídico a formato audio/podcast.
**How to apply:** Al retomar, verificar créditos ElevenLabs disponibles, identificar el siguiente artículo pendiente en el Excel, y seguir el flujo completo abajo.

---

## Archivos clave

### Excel maestro (fuente de verdad)
- **OneDrive (fuente principal — usar siempre esta):**
  `/Users/erocha/Library/CloudStorage/OneDrive-Personal/OwnMedia/TCA/CJ_Volumenes_Estatus_Dinamica_PRO.xlsm`
- **Google Drive (espejo):**
  `/Users/erocha/Library/CloudStorage/GoogleDrive-enrique@dstudio.mx/Shared drives/OWNMEDIA NEW/TČA/CONCIENCIA JURIDICA/ESPEJO ONE DRIVE/CJ_Volumenes_Estatus_Dinamica_PRO.xlsm`

### Columnas del Excel (Sheet1) — mapeado verificado
| Col | Contenido |
|-----|-----------|
| A | Volumen (ej. XI) |
| B | Mes de publicación |
| C | Núm. de artículo |
| D | Título versión impresa |
| E | Título (puede tener fórmula HYPERLINK) |
| F | Título Web |
| H | Autor |
| V | URL Artículo (col 22, idx 21 — usar ws['V18'] para escribir) |
| W | Audio (checkbox — True si audio subido a Spotify) |
| X | Auxiliar Audio (checkbox — True si MP3 generado localmente) |

### Audios generados
- **Ruta:** `/Users/erocha/Library/CloudStorage/OneDrive-Personal/OwnMedia/TCA/Audios/[VOLUMEN]/`
- **Nomenclatura:** `[Vol]_[Núm]_[slug]_[autor].mp3`
- **Ejemplo:** `XI_04_libertad-expresion-era-digital_ramon-flores.mp3`
- **Carpetas existentes:** X, XI, XII (todas con archivos COMPLETO compilados)

### Archivos M4A para Spotify (generados mayo 25, 2026)
| Volumen | Archivo M4A | Tamaño |
|---------|-------------|--------|
| X | `CJ_Volumen_X_COMPLETO_spotify.m4a` | 175 MB |
| XI | `CJ_Volumen_XI_COMPLETO_spotify.m4a` | 137 MB |
| XII | `Conciencia_Juridica_Volumen_XII_COMPLETO_v4.m4a` | 163 MB |

### Descripciones HTML Spotify (formato rich text — modelo: Vol XII)
- XII: ya existía (con URLs)
- XI: `Audios/XI/descripcion_spotify_vol_xi.html` ✓ (generado may 25, 2026)
- X: `Audios/X/descripcion_spotify_vol_x.html` ✓ (generado may 25, 2026)

Formato HTML: párrafo intro con temas → timestamps `(HH:MM:SS)` con `<a href>` → footer "CJ es una publicación jurídica..." + link www.

### Muestras de voz (para clonar si se necesita)
`/Users/erocha/Library/CloudStorage/GoogleDrive-enrique@dstudio.mx/Shared drives/OWNMEDIA NEW/TČA/CONCIENCIA JURIDICA/PODCAST/VOCES/`

---

## Voces clonadas en ElevenLabs

| Autor | Voice ID |
|-------|----------|
| Mauricio Alejandro Espinosa Álvarez | `KmYbyUq1g6U3BnmNoNJo` |
| Raúl Alonso Flores Fernández | `owhayiBsLKCQAqE7no5n` |
| Ramón Flores García | `zEwY7kKaIxp856vcQ1em` |
| Alejandro Zermeño Medina | `NWkkBcu2wECXBODqFTZb` |
| Igor Trujillo Čenčič | `QuM41uJA0kPowhrCRY7k` |
| Tatiana Madrid Marco | `yjM7EfEy4N5TxAENurE7` |
| José Hernández Delgado Chacón | `CoIptonbQoDXCem19YSc` |
| Ximena López León | *(sin clonar aún)* |

**API Key activa:** `sk_e01b8b32db0fa148c6b231e3d895c283fbd0ab35c0a48f46`
**Plan:** Creator — ~152,531 caracteres/mes (verificar créditos al retomar)

---

## Parámetros de generación

```python
MODEL     = "eleven_multilingual_v2"
SPEED     = 0.8          # Confirmado en sesión mayo 2026
STABILITY = 0.5
SIMILARITY_BOOST = 0.75
CHUNK_SIZE = 2500        # chars por llamada API
```

---

## Flujo completo por artículo

1. **Leer del Excel** (por número de fila): col A (volumen), B (núm), E (título), G (autor), U (URL)
2. **Fetch del texto** desde la URL — usar la URL canónica (a veces difiere de la del Excel, verificar redirect)
   - Extraer con selector CSS: `div.elementor-widget-theme-post-content`
   - Limpiar: quitar `[1]`, `Fuente: Nota original...` y espacios extra
3. **Generar audios** vía ElevenLabs:
   - `00_titulo.mp3` — solo el título (col E)
   - `silencio_2s.mp3` — `ffmpeg -f lavfi -i anullsrc -t 2`
   - `chunk_01.mp3`, `chunk_02.mp3`... — cuerpo del artículo en chunks de 2500 chars
4. **Concatenar** con ffmpeg (`-f concat`) → MP3 final
5. **Guardar** en `Audios/[VOLUMEN]/[nomenclatura].mp3`
6. **Marcar W[fila] = True** en el Excel con openpyxl (`keep_vba=True`)

---

## Estado de artículos por volumen (actualizado mayo 29, 2026)

Estrategia de subida: de más reciente a más antiguo (XII → I).

| Volumen | MP3/Audio | Spotify | Notas |
|---------|-----------|---------|-------|
| XII | ✅ | ✅ publicado may 23, 2026 | 7 artículos |
| XI | ✅ | ✅ publicado | 7 artículos |
| X | ✅ | ✅ publicado | 8 artículos |
| IX | ✅ | ✅ publicado | 6 artículos |
| VIII | ✅ | ✅ publicado | 9 artículos |
| VII | ✅ | ✅ publicado | 8 artículos |
| VI | ✅ | ✅ publicado | COMPLETO M4A en carpeta |
| V | ✅ | ✅ publicado | COMPLETO M4A en carpeta |
| IV | ✅ | ✅ publicado | 13 MP3s individuales + Excel actualizado may 29 |
| III | ✅ | ✅ publicado | 12 MP3s individuales + Excel actualizado may 29 |
| II | ✅ | ✅ publicado | 11 MP3s individuales + Excel actualizado may 29 |
| I | ✅ | ✅ publicado | 9 MP3s individuales + Excel actualizado may 29 |

### Volumen X — COMPLETO ✓
Archivos MP3 individuales generados, compilado `CJ_Volumen_X_COMPLETO_spotify.mp3` (165 MB) y M4A listo.
Ruta: `/Users/erocha/Library/CloudStorage/OneDrive-Personal/OwnMedia/TCA/Audios/X/`

| Núm | Slug archivo | Autor | Timestamp |
|-----|-------------|-------|-----------|
| 00 | carta-editorial-vol-x_igor-trujillo | Igor Trujillo Čenčič | 00:00:00 |
| 01 | inteligencia-artificial-y-derecho_mauricio-espinosa | Mauricio Espinosa Álvarez | 00:01:56 |
| 02 | responsabilidad-penal-adolescentes_cinthya-garcia | Cinthya G. García Valadez | 00:28:22 |
| 03 | toros-sin-violencia-nuevo-debate-juridico_raul-alonso-flores | Raúl Alonso Flores Fernández | 00:44:36 |
| 04 | firma-electronica-contratos-smart-contracts_ximena-lopez | Ximena López León | 00:51:09 |
| 05 | justicia-procesal-unificada-codigo-nacional_ramon-flores | Ramón Flores García | 01:36:51 |
| 06 | dona-carlota-justicia-por-propia-mano_jose-hernandez | José Hernández Delgado Chacón | 02:00:43 |
| 07 | el-despojo-fenomeno-estructural_alejandro-zermeno | Alejandro Zermeño Medina | 02:26:33 |

### Volumen XI — COMPLETO ✓
Archivos MP3 individuales generados, compilado `CJ_Volumen_XI_COMPLETO_spotify.mp3` (130 MB) y M4A listo.
Ruta: `/Users/erocha/Library/CloudStorage/OneDrive-Personal/OwnMedia/TCA/Audios/XI/`

| Núm | Slug archivo | Autor | Timestamp |
|-----|-------------|-------|-----------|
| 00 | carta-editorial-vol-xi_igor-trujillo | Igor Trujillo Čenčič | 00:00:00 |
| 01 | derecho-a-decidir-en-mexico_alejandro-zermeno | Alejandro Zermeño Medina | 00:03:46 |
| 02 | prision-preventiva-oficiosa-scjn_jose-hernandez | José Hernández Delgado Chacón | 00:21:27 |
| 03 | scj-invalida-prision-vitalicia_raul-alonso-flores | Raúl Alonso Flores Fernández | 00:42:36 |
| 04 | libertad-expresion-era-digital_ramon-flores | Ramón Flores García | 00:52:47 |
| 05 | matrimonio-igualitario-mexico_ximena-lopez | Ximena López León | 01:20:43 |
| 06 | compensacion-economica-divorcio-mexico_mauricio-espinosa | Mauricio Espinosa Álvarez | 02:07:52 |

### Volumen XII — COMPLETO ✓ (publicado Spotify, mayo 23, 2026)
Archivo final: `Conciencia_Juridica_Volumen_XII_COMPLETO_v4.mp3` + M4A (163 MB, 2h 47m 51s)
Ruta: `/Users/erocha/Library/CloudStorage/OneDrive-Personal/OwnMedia/TCA/Audios/XII/`

| Núm | Autor | Timestamp |
|-----|-------|-----------|
| 00 | Igor Trujillo Čenčič | 00:00:00 |
| 01 | Alejandro Zermeño Medina | 00:04:36 |
| 02 | José Hernández Delgado Chacón | 01:00:43 |
| 03 | Raúl Alonso Flores Fernández | 01:18:03 |
| 04 | Ramón Flores García | 01:28:24 |
| 05 | Tatiana Madrid Marco | 01:52:10 |
| 06 | Mauricio Alejandro Espinosa Álvarez | 02:35:45 |

**Excel backup:** `CJ_Volumenes_Estatus_Dinamica_PRO_BACKUP_20260503_203018.xlsm`

---

## Pendiente / próxima sesión

- ✅ COMPLETO: todos los volúmenes (I–XII) publicados y marcados en Excel (may 29, 2026)
- Ximena López León sin voz clonada — no bloquea, sus artículos ya están publicados
