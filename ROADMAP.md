# Roadmap

Reglas y contenidos propuestos que **todavía no forman parte de la guía**. Al
incorporarse al [README](README.md) se quitan de acá y se registran en el
[CHANGELOG](CHANGELOG.md).

Estos ítems vienen de la "Whishlist" del viejo `changelog.txt`. Están tal como fueron
anotados: son apuntes, no reglas redactadas. Antes de incorporar cualquiera de ellos
hay que darle la forma del resto de la guía (número de regla, ancla, motivo y ejemplos
de *mal* / *bien*).

## Reglas propuestas

### Chequear las variables antes de un `for each`

Mejora la performance evitando recorrer la tabla cuando ya se sabe que no hay nada
que buscar.

```javascript
if not &TeamId.IsEmpty()
	for each Team
		&OrganizationId = OrganizationId
	endfor
endif
```

### Usar `FromString` al leer un booleano desde un string

Devuelve `True` tanto para `1` como para `TRUE`.

### Convención de nombres pendiente

La guía ya cubre el sufijo por acción en la regla 1.5 (`ClienteUpsert`), pero estos
casos no están contemplados:

- TextBlock: `Text[Nombre]`
- SDT: `[Nombre]SDT`
- Procedimiento que inserta un registro en una tabla: `[Nombre]Insert`
- Procedimiento que inserta o actualiza un registro en una tabla: `[Nombre]Upsert`

### No usar nombres de clase directamente

Utilizar un prefijo para poder referenciar dónde se usa la clase: `ThemeClass:EditForm`.

### Procedimiento para obtener un parámetro

- Al resolverlo por referencias se puede ver quién lo usa.
- Darle un valor por defecto o inicializarlo si es necesario.
- Utilizar un dominio de parámetros.

## Secciones propuestas

- **Glosario.**
- **Patrón — Sobrecarga en GeneXus.**

## Inconsistencias detectadas en la guía

Contenido ya publicado que se contradice y conviene resolver:

- **Los ejemplos de la regla 2.1 están invertidos respecto de la propia regla.** La regla
  pide tabuladores en lugar de espacios, pero el ejemplo marcado como *bien* usa cuatro
  espacios y uno de los marcados como *mal* usa tabuladores.
- **Los ejemplos usan comilla doble, contra la regla 5.3.** Desde el 2021-08-25 la guía
  pide comilla simple por defecto, pero los ejemplos del resto del documento (reglas 1.3,
  2.1, 5.1, entre otras) siguen con comilla doble.
- **La regla 2.1 usa `DocumentoTipos.Venta` y `DocumentoTipo.Venta` en el mismo bloque.**
  Según la regla 1.4, el dominio enumerado va en plural.
- **Numeración y anclas rotas en `README.md`.** La traducción al inglés se dejó con la
  numeración corregida; el español todavía arrastra estos errores y conviene alinearlo:
    - Los dos SDT de la sección 4 están numerados ambos como `4.1` (el segundo debería
      ser `4.2`, como quedó en inglés).
    - La regla 7.5 muestra la etiqueta `[7.4]` (debería ser `[7.5]`).
    - Anclas `<a name="...">` duplicadas o cuyo enlace no coincide con el ancla: en las
      reglas 3.2 (`enums-use` repetido), 5.3 (enlaza a `strings-trans`), 7.5, 9.1
      (enlaza a `parms--title`), 10.2 y 10.8.
