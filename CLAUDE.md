# Guía de estilo para el desarrollo en GeneXus

Repositorio de un documento (una guía de estilo), no de software. La guía vive en
`README.md`. No hay build ni tests; la "verificación" es que los enlaces internos
resuelvan y que los dos idiomas estén sincronizados.

## Sincronización español ↔ inglés

- **`README.md` (español) es la fuente canónica.** `README_en.md` es su traducción y
  siempre va detrás.
- **El README en inglés debe estar sincronizado con el español.** Todo cambio en
  `README.md` que agregue, modifique o elimine una regla debe reflejarse en
  `README_en.md` en el mismo cambio. Los dos archivos tienen que tener las mismas reglas,
  con los mismos números y las mismas anclas (`<a name="1.4">`).
- Ante una discrepancia entre ambos, el español es el correcto; se corrige el inglés.
- En los ejemplos, los **identificadores sí se traducen** al inglés siguiendo la
  convención del documento (`ClienteCrear` → `ClientCreate`, `DocumentoTipos` →
  `DocumentTypes`), con glosario coherente. También los comentarios `// mal` / `// bien`
  → `// bad` / `// good`. No se tocan las palabras clave del lenguaje ni las constantes
  de sistema.
- Para ver qué reglas faltan en la traducción:

  ```bash
  diff <(grep -o 'name="[0-9.]*"' README.md) <(grep -o 'name="[0-9.]*"' README_en.md)
  ```

## Convenciones del repo

- Fin de línea **CRLF** en todo el repo (lo fija `.editorconfig`).
- Los cambios ya publicados se registran en `CHANGELOG.md` (formato Keep a Changelog).
- Las reglas propuestas y todavía no incorporadas van en `ROADMAP.md`, no en el CHANGELOG.
- No renumerar reglas existentes: las anclas numéricas son enlaces públicos.
- El proceso completo de contribución está en `CONTRIBUTING.md`.
