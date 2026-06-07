---
name: Collins Pearls Website
description: Landing page estática para Alex Collins, personal pearl shopper con base en Takaroa, Polinesia Francesa. Sin fotos, todo CSS/tipografía.
type: project
originSessionId: bf3740a6-8fb2-4e63-a93d-b7cbc331a347
---
Sitio de una sola página para Alex Collins — no es una tienda, es un servicio de personal shopper de perlas. Posicionamiento: "Swiss banker for pearls".

**Archivo de trabajo:** `/tmp/collins_pearls.html` (fuente) + `~/Desktop/Collins_Pearls_v4.html` (copia de trabajo)
**Archivos SEO complementarios:** `/tmp/collins_seo/llms.txt`, `robots.txt`, `sitemap.xml` → para subir a la raíz de collinspearls.com

**Stack:** HTML estático · CSS puro · GSAP + ScrollTrigger (CDN) · Cormorant Garamond (Google Fonts) · Canvas 2D

**Paleta (Polynesian Lagoon, warm):**
- `--s1: #082832` Entry (hero, profundo)
- `--s2: #0A4A40` Service (jade cálido)
- `--s3: #0D4E58` Range (agua abierta)
- `--s4: #091E2A` Alex (noche en el atolón)
- `--s5: #0F5C5C` Contact (brillo de superficie)
- `--aqua: #3EC5B8` · `--cream: #EDE8DC` · `--muted: #5A9A90`

**Estructura de 5 secciones:**
1. **Entry** (#082832) — Canvas caustics + burbujas canvas, ghost "PEARLS", título "Collins / Pearls", coordenadas Takaroa
2. **Service** (#0A4A40) — "He doesn't sell pearls. He finds yours." + 3 pillars (Any Origin / Any Species / Anywhere on Earth)
3. **Range** (#0D4E58) — 5 pearl cards (CSS gradient + orb flotante, SIN fotos) + 4 rare cards (Conch / Melo / Abalone / Natural Saltwater)
4. **Alex** (#091E2A) — Quote "Twenty years ago / I moved to an atoll..." + stats count-up (20 yrs, 78 atolls) + lista de perlas exóticas
5. **Contact** (#0F5C5C) — WhatsApp +689 74 75 42 · hello@collinspearls.com · @collinspearls IG

**Decisiones de diseño clave:**
- SIN fotos ("evita las fotos") — las 5 pearl cards usan CSS gradient + orb radial-gradient flotante + ghost word
- SIN wave dividers entre secciones — se eliminaron; borde limpio de color a color
- Ghost words: PEARLS / FIND / EVERY / ALEX / BEGIN — position:absolute en cada sección, opacity 0.12-0.22 (visible pero sutil), con parallax GSAP scrub
- Burbujas: canvas en hero (#entry, position:absolute z-index:1) + CSS divs inyectados por JS en secciones 2-5 (.bbl-wrap / .bbl)
- Canvas (caustics + bubbles) debe ser position:absolute z-index:1 DENTRO de #entry — si se vuelve fixed se esconde detrás de los fondos sólidos
- Water-layer animado (radial gradient blobs) en cada sección via ::before/::after
- Baroque card: border-radius orgánico + @keyframes baroqueWarp para deformar el orb

**Why:** Cliente es personal pearl shopper, no tienda. Las fotos de la granja/buzo hacen referencia a su pasado que quiere dejar atrás. El foco es la exclusividad del servicio de búsqueda personalizada mundial.

**How to apply:** En retomar, el archivo activo es `/tmp/collins_pearls.html`. La siguiente conversación puede retomar desde ahí. Pendiente: decidir hosting/deployment (posiblemente Netlify o subir a collinspearls.com directo por FTP).
