---
name: feedback-openpyxl-xlsx
description: "Problemas de compatibilidad openpyxl→Excel al insertar filas: array formula refs desfasadas, fórmulas regulares con refs erróneas, merged cells. Verificación obligatoria antes de entregar."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: a9550654-8570-4315-acbd-1c5138cd4fd1
---

Antes de guardar y entregar cualquier archivo `.xlsx` modificado con openpyxl (especialmente cuando se inserta o elimina filas), ejecutar las siguientes verificaciones:

**Why:** Al insertar filas con `ws.insert_rows()`, openpyxl NO actualiza automáticamente:
1. El atributo `ref="CXX"` de las array formulas `<f t="array">` en el XML — quedan apuntando a la fila anterior y Excel rechaza abrir el archivo
2. Las referencias en fórmulas regulares (`<f>BN+CN+DN</f>`) que ya existían antes de la inserción — quedan desfasadas N filas
3. Los rangos de `SUM()` y `SUMIF()` que cubrían la zona afectada
4. Las celdas con `MergedCell` — asignar `.value` directamente falla; hay que desmerge primero con `ws.unmerge_cells()`

**How to apply:** Checklist de verificación ANTES de entregar un xlsx modificado:

```python
# 1. Verificar array formula refs (XML)
import zipfile, re
with zipfile.ZipFile(path) as z:
    c = z.read('xl/worksheets/sheetN.xml').decode()
    # Buscar <c r="CXX"...<f t="array" ref="CYY" donde XX != YY
    mismatches = re.findall(r'<c r="([A-Z]+(\d+))"[^>]*><f t="array" ref="[A-Z]+(\d+)"', c)
    for cell_ref, cell_row, ref_row in mismatches:
        if cell_row != ref_row:
            print(f"PROBLEMA: celda {cell_ref} tiene ref={ref_row}")

# 2. Verificar fórmulas regulares de suma por fila (tabla mensual, etc.)
#    Cada celda EN debe tener fórmula =BN+CN+DN
for ri in range(first_data_row, last_data_row+1):
    v = ws.cell(ri, col_E).value
    expected = f'=B{ri}+C{ri}+D{ri}'
    assert v == expected, f"E{ri} tiene {v!r}"

# 3. Verificar MergedCells antes de asignar valor
from openpyxl.cell import MergedCell
if isinstance(ws.cell(row, col), MergedCell):
    # Encontrar el rango y desmerge primero
    for m in ws.merged_cells.ranges:
        if ws.cell(row, col).coordinate in m:
            ws.unmerge_cells(str(m))
            break
```

**Fix para array formula refs desfasadas (XML directo):**
```python
import zipfile, re, shutil
with zipfile.ZipFile(src, 'r') as zin:
    with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if 'sheet' in item.filename and item.filename.endswith('.xml'):
                c = data.decode('utf-8')
                # Corregir array formula refs para cada columna
                for col in 'ABCDEFGH':
                    pattern = rf'(<c r="{col}(\d+)"[^>]*>(?:<v>[^<]*</v>)?<f t="array" ref="{col}(\d+)")'
                    def rep(m):
                        full, cr, rr = m.group(1), m.group(2), m.group(3)
                        return full.replace(f'ref="{col}{rr}"', f'ref="{col}{cr}"') if cr != rr else full
                    c = re.sub(pattern, rep, c)
                data = c.encode('utf-8')
            zout.writestr(item, data)
shutil.copy2(tmp, src)
```

**Orden correcto de operaciones:**
1. Hacer todos los cambios con openpyxl (incluyendo desmerge y valores)
2. `wb.save(path)` con openpyxl
3. DESPUÉS hacer correcciones XML directas en el ZIP (array refs, fórmulas regulares desfasadas)
4. Verificar reabriendo con `openpyxl.load_workbook(path, data_only=False)` y confirmar que las fórmulas son correctas

**Regla adicional:** [[feedback-excel-update]] — también aplica `ws['V18']=valor` (ref directa) para celdas simples.
