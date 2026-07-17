# Cómo contribuir

Gracias por querer mejorar la guía. Este documento explica cómo proponer cambios y,
sobre todo, cómo mantener sincronizadas la versión en español y la traducción al inglés.

## Antes de empezar

- Para una corrección puntual (tipeo, enlace roto, ejemplo equivocado), mandá el Pull
  Request directo. No hace falta abrir un issue antes.
- Para una regla nueva o el cambio de una existente, **abrí primero un
  [issue](https://github.com/sincrum/genexus/issues)**. Una regla se discute antes de
  redactarse: cambiarla obliga a revisar el código de todos los equipos que siguen la guía.
- Si la idea ya está anotada en [ROADMAP.md](ROADMAP.md), decilo en el issue y trabajá
  sobre eso.
- También podés escribir a [info@sincrum.com](mailto:info@sincrum.com).

## El español es la fuente

`README.md` (español) es el documento canónico. `README_en.md` es una traducción y
**siempre va detrás**. Toda regla nueva se redacta primero en español.

Esto no es una preferencia idiomática, es la regla que decide qué archivo gana cuando
los dos difieren: ante una discrepancia, el español es el correcto y el inglés es el
que hay que arreglar.

## Cómo agregar o modificar una regla

Cada regla tiene esta forma. Respetala, porque las anclas son enlaces públicos:

```markdown
  <a name="naming--descriptive"></a><a name="1.1"></a>
  - [1.1](#naming--descriptive) Se debe ser descriptivo con los nombres.
	> Se intenta que el nombre sea autodescriptivo.

    ```javascript
    // mal
    Proc: CliCre

    // bien
    Proc: ClienteCrear
    ```
```

Puntos a cuidar:

1. **Dos anclas por regla**: una semántica (`naming--descriptive`) y una numérica (`1.1`).
   La numérica no se reutiliza ni se recicla nunca.
2. **La cita `>` es el motivo.** Una regla sin motivo es una opinión: explicá por qué.
3. **Ejemplos de `// mal` y `// bien`**, en ese orden, en un bloque ` ```javascript `
   (no hay resaltado de sintaxis para GeneXus; javascript es lo que más se le parece).
4. **No renumeres las reglas existentes** para insertar una en el medio. Agregá al final
   de la sección. Renumerar rompe todos los enlaces que apuntan a la guía desde afuera.
5. Si agregás una sección, sumala a la **Tabla de Contenidos**.
6. Registrá el cambio en [CHANGELOG.md](CHANGELOG.md), bajo `## [No publicado]`.

## Sincronización español ↔ inglés

Las dos versiones están sincronizadas: ambas tienen las mismas 41 reglas. Mantenerlas
así es el punto central de este documento: cada cambio en el español tiene que llegar
al inglés.

### Si cambiás el español

No estás obligado a traducir: preferimos un aporte en español a ningún aporte. Pero
si no traducís, el cambio queda registrado como deuda. Elegí una:

- **Traducís en el mismo PR.** Es lo ideal, y lo único que mantiene el desfasaje en cero.
- **No traducís.** Entonces abrí un issue con la etiqueta `traducción` que diga qué regla
  quedó sin traducir, y enlazalo desde tu PR.

### Si traducís al inglés

- Traducí **contra el español actual**, no contra una versión vieja de la traducción.
- Mantené los mismos números de regla y las mismas anclas numéricas que el español. Una
  regla `1.4` tiene que ser la misma regla en los dos archivos: así los dos documentos se
  pueden comparar y enlazar entre sí.
- **Los identificadores de los ejemplos sí se traducen**, siguiendo la convención del
  documento en inglés: `ClienteCrear` → `ClientCreate`, `DocumentoTipos` →
  `DocumentTypes`, `Venta` → `Sale`. Mantené el glosario coherente en todo el documento
  (una misma entidad se traduce siempre igual). También se traducen los comentarios
  `// mal` / `// bien` → `// bad` / `// good`. Lo único que no se toca son las palabras
  clave del lenguaje (`for each`, `parm`, `endsub`) y las constantes de sistema.
- Los enlaces al wiki de GeneXus apuntan a la versión en inglés cuando existe.
- Sumate a la sección **Colaboradorators** de `README_en.md`.

### Cómo ver el desfasaje

Las anclas numéricas permiten comparar qué reglas faltan en la traducción:

```bash
diff <(grep -o 'name="[0-9.]*"' README.md) <(grep -o 'name="[0-9.]*"' README_en.md)
```

## Estilo del propio repo

- La identación la fija [`.editorconfig`](.editorconfig). Instalá el plugin de
  EditorConfig en tu editor y no vas a tener que pensar en esto.
- Los archivos Markdown se identan con espacios, no con tabuladores: la regla 2.1 habla
  del código GeneXus, no de este documento. Un tabulador rompe el anidado de las listas.

## Licencia

Al contribuir aceptás que tu aporte se publique bajo
[CC BY-SA 4.0](LICENSE), igual que el resto de la guía.
