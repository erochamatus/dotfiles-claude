---
name: Actualizar celdas en Excel .xlsm con openpyxl
description: Cómo escribir correctamente en el archivo Excel de Conciencia Jurídica (y otros .xlsm) usando openpyxl
type: feedback
originSessionId: 1d79871a-1e71-480b-aa36-a37cf11a7bc0
---
Usar siempre referencia directa por celda (`ws['V18'] = valor`), NO iterar filas y asignar por índice (`row[21].value = valor`).

**Why:** La asignación por índice en `iter_rows()` no persiste correctamente en archivos `.xlsm` con `keep_vba=True`. La referencia directa por coordenada sí funciona y es verificable de inmediato.

**How to apply:** Al actualizar celdas en el Excel maestro de CJ (`CJ_Volumenes_Estatus_Dinamica_PRO.xlsm`):
1. Abrir con `openpyxl.load_workbook(path, keep_vba=True)`
2. Escribir con `ws['V18'] = url` (referencia directa)
3. Guardar con `wb.save(path)`
4. Verificar reabriendo el archivo y leyendo la celda antes de reportar éxito
