# Changelog

Todos los cambios notables de esta guía se documentan en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).
Como la guía es un documento y no un software versionado, cada entrega se identifica
por su fecha (`AAAA-MM-DD`) en lugar de por un número de versión.

Las reglas propuestas y todavía **no** incorporadas a la guía viven en
[ROADMAP.md](ROADMAP.md), no acá: este archivo solo registra lo que ya está publicado.

## [No publicado]

### Agregado
- `LICENSE` con el texto completo de la licencia CC BY-SA 4.0. Hasta ahora la licencia
  se declaraba solo en el README, con lo cual GitHub no la reconocía.
- `.editorconfig`, que fija el tabulador como identación por defecto (regla 2.1).
- `CONTRIBUTING.md`, con el proceso de contribución y de sincronización entre la
  versión en español y la traducción al inglés.
- `CLAUDE.md` con las convenciones del repo, incluida la regla de sincronización ES↔EN.
- `CHANGELOG.md` (este archivo) y `ROADMAP.md`.

### Cambiado
- Se sincroniza la traducción al inglés (`README_en.md`) con el español: pasa de 27 a 41
  reglas. Se agregan las secciones Subrutinas (9.1) y Buenas prácticas (10.1–10.9), las
  reglas 3.2, 3.3, 5.3 y 7.5, y la sección Objetivos. Se actualiza la regla 1.4 (dominios
  enumerados en plural), que quedaba con el criterio viejo, y las listas de recursos y
  empresas. Se corrige el encabezado "Colaboradorators" → "Collaborators".

### Eliminado
- `changelog.txt`, reemplazado por `CHANGELOG.md` y `ROADMAP.md`.

## [2024-08-19]

### Agregado
- Neuronic a la lista de empresas que utilizan la guía.

## [2021-08-25]

### Cambiado
- Regla 1.4: los dominios enumerados pasan a nombrarse con el calificador en **plural**
  (`DocumentoTipos`), antes se pedía en singular (`DocumentoTipo`). El motivo es evitar
  que los atributos colisionen con los dominios enumerados.
- Regla 5.3: pasa a usarse **comilla simple** por defecto, revirtiendo la comilla doble
  adoptada el 2018-04-24. El motivo es que los eventos y subrutinas que genera GeneXus
  ya usan comilla simple.

## [2019-12-27]

### Cambiado
- Regla 6.2: se aclara que no hace falta dejar una línea en blanco antes del comentario
  cuando se está comentando un `where` de un `for each`.
- Correcciones de tipeo en las reglas 6.1 y 6.2.

## [2019-07-03]

### Corregido
- Ejemplo de la regla 2.3.
- Identación y tabla de contenidos.

## [2019-07-02]

### Agregado
- Sección "Subrutinas" (aporte de Big Cheese).
- Big Cheese a la lista de empresas que colaboran con el estándar.
- Buenas prácticas: al agregar campos nuevos, asignarles `null` como default value, para
  no generar una reorganización con transferencia de datos.
- Buenas prácticas: evitar el acceso a sesiones desde procedimientos, por pertenecer al
  dominio del problema.
- Buenas prácticas: no incluir lógica de negocio en la interfaz.
- Los dominios enumerados no deben tener valores por defecto (`""` o `0` en numéricos).

### Cambiado
- Se reescribe la sección de comentarios.
- Ajustes varios por coherencia.

## [2018-08-01]

### Agregado
- I+Dev a la lista de empresas que utilizan la guía.

## [2018-05-24]

### Agregado
- GeneXus y TributApp a la lista de empresas que utilizan la guía.

## [2018-05-23]

### Cambiado
- Comandos: se adopta la nueva sintaxis de `call`.

## [2018-04-26]

### Cambiado
- La licencia pasa a ser Creative Commons Atribución-CompartirIgual 4.0 Internacional
  (CC BY-SA 4.0).

## [2018-04-24]

### Agregado
- Recursos: se incorporan nuevos recursos.
- Buenas prácticas: Default Properties (Read committed, no generar prompts).
- Buenas prácticas: los SDT de servicios públicos deben tener un namespace fijo.
- Buenas prácticas: versionado, tanto en sintaxis como en binarios. El número de versión
  puede almacenarse además en la base de datos, para aplicar un patch puntual al
  actualizar.
- Los dominios de estados pueden crearse como `char`, para resultar más descriptivos
  en la base de datos.
- Conformación de scripts separando el texto del código, para que solo el texto quede
  expuesto a traducción:

  ```javascript
  &Msg = format( !"confirm('%1')", "¿Está seguro de agregar excepción?")
  &LstExc.JSEvent( "onclick", &Msg)
  ```

### Cambiado
- Strings: se adopta la comilla doble por defecto. (Revertido el 2021-08-25.)
- Mejoras y correcciones varias.
