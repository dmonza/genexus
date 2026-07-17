# Pipeline de build & deploy de KB GeneXus

Plantilla de pipeline de Jenkins (Declarative Pipeline) para **compilar y desplegar
una Knowledge Base (KB) de GeneXus** de forma automatizada, tanto para generador
**.NET** como **Java**.

El pipeline sincroniza la KB desde GeneXus Server, ejecuta un `BuildAll`, empaqueta las
Deployment Units (frontend y backend) y las publica en una carpeta destino.

- **`kbgenexus.jenkinsfile`** — el pipeline en sí.
- **`genexus-tasks.msbuild`** — script MSBuild de orquestación (build, tests y
  mantenimiento de la KB) que el pipeline invoca para los targets `Update` y `BuildAll`.

> Autor: Daniel Monza — https://sincrum.com

---

## Requisitos previos

En el **agente de Jenkins** donde corre el pipeline:

- **GeneXus instalado**. La carpeta de instalación (`GX_INSTALL_DIR`) debe contener:
  - `deploy.msbuild`
  - `GeneXus.Tasks.targets`
  - `Genexus.Server.Tasks.targets`
  - `GXtest.targets`
- **MSBuild** registrado en Jenkins → *Manage Jenkins → Global Tool Configuration*.
- **Acceso al GeneXus Server** desde el que se sincroniza la KB.
- El archivo `genexus-tasks.msbuild` disponible en el workspace (se referencia como
  `${WORKSPACE}\genexus-tasks.msbuild`).

En **Jenkins** (Credentials):

| Credencial | Tipo | Uso |
|---|---|---|
| `GXSERVER_CREDID` | *Username with password* | Usuario/clave de GeneXus Server (checkout de la KB). |
| `GXAPPKEY_CREDID` | *Secret text* | `APPLICATION_KEY` usado al empaquetar las Deployment Units. |

> El `APPLICATION_KEY` se inyecta como variable de entorno desde la credencial *secret
> text*, de modo que **nunca queda expuesto** en el Jenkinsfile ni en los logs.

---

## Configuración

Toda la configuración del template está en el bloque `environment` del Jenkinsfile.
Revisá y ajustá **todos los valores marcados con `// TODO`** antes de usarlo en un
entorno nuevo.

### Rutas y servidor

| Variable | Descripción | Ejemplo |
|---|---|---|
| `GX_INSTALL_DIR` | Carpeta raíz de la instalación de GeneXus en el agente. | `C:\Datos\GeneXus\GeneXus18u13` |
| `GXSERVER_URL` | URL del GeneXus Server. | `http://genexus-server.example.com/kbs` |
| `KB_PATH` | Ruta local de la KB en el agente. | `C:\KBs\MiKB` |
| `KB_NAME` | Nombre de la KB en GeneXus Server. | `MiKB` |
| `KB_ENVIRONMENT` | Environment de la KB a compilar/desplegar. | `ProdNet` / `ProdJava` |
| `DEPLOY_TARGET` | Carpeta destino donde se publican las Deployment Units. | `C:\Versionado\Deploy` |

### Jenkins (tools y credenciales)

| Variable | Descripción |
|---|---|
| `MSBUILD_TOOL` | ID del MSBuild registrado en *Global Tool Configuration*. |
| `GXSERVER_CREDID` | ID de la credencial *username/password* de GeneXus Server. |
| `GXAPPKEY_CREDID` | ID de la credencial *secret text* con el `APPLICATION_KEY`. |

### Proyectos y objetos a empaquetar

El pipeline genera **dos Deployment Units en paralelo**: frontend y backend.

| Variable | Descripción |
|---|---|
| `FRONTEND_PROJECT` | Nombre del `.gxdproj` del frontend. |
| `FRONTEND_OBJECTS` | Objetos a incluir en la DU frontend. |
| `BACKEND_PROJECT` | Nombre del `.gxdproj` del backend. |
| `BACKEND_OBJECTS` | Objetos a incluir en la DU backend. |

> El frontend se empaqueta con `INCLUDE_GAM=True` y el backend con `INCLUDE_GAM=False`.

### Empaquetado: .NET vs Java

El formato de salida se controla **por Deployment Unit** con `*_PACKAGE_FORMAT`:

| Variable | Valores | Descripción |
|---|---|---|
| `FRONTEND_PACKAGE_FORMAT` | `Automatic` \| `war` \| `ear` | Formato del paquete del frontend. |
| `BACKEND_PACKAGE_FORMAT` | `Automatic` \| `war` \| `ear` | Formato del paquete del backend. |
| `TARGET_JRE` | ej. `11` | Versión del JRE destino (**solo Java**). Default de GeneXus: `9`. |
| `APP_SERVER` | ej. `Generic Servlet 6.0` | Application Server (**solo Java**). |

- **`Automatic`** → comportamiento por defecto. En .NET produce el paquete estándar
  (ZIP); en Java GeneXus decide WAR/EAR según los objetos seleccionados.
- **`war` / `ear`** → fuerza la generación del paquete Java correspondiente. Solo en
  este caso se pasan `TARGET_JRE` y `APP_SERVER` a las tareas de GeneXus.

> `TARGET_JRE` y `APP_SERVER` se ignoran cuando el formato es `Automatic`, por lo que
> dejarlos seteados no afecta un deploy .NET.

### Variables derivadas (no editar)

`BUILD_SCRIPT`, `STAGING_DIR`, `FRONTEND_STAGE` y `BACKEND_STAGE` se calculan a partir
del workspace y no requieren ajuste.

---

## Funcionamiento

El pipeline ejecuta cuatro etapas, más un bloque `post`:

```
GXServerCheckout → GXBuild → Package Deployment Units (paralelo) → Deploy
```

1. **GXServerCheckout** — sincroniza la KB desde GeneXus Server al workspace local.
   Invoca `genexus-tasks.msbuild /t:Update` con las credenciales de servidor.

2. **GXBuild** — ejecuta `genexus-tasks.msbuild /t:BuildAll` sobre la KB en el
   environment configurado (`BuildAll ForceRebuild="false" CompileMains="true"`).

3. **Package Deployment Units** — genera frontend y backend **en paralelo**. Por cada
   DU corre los dos pasos estándar de GeneXus (ver *Empaquetado de Deployment Units*).

4. **Deploy** — copia (`xcopy`) los paquetes desde `staging\frontend` y
   `staging\backend` a `DEPLOY_TARGET\frontend` y `DEPLOY_TARGET\backend`.

**`post`:**
- `always`: archiva los artefactos de `staging/**` y limpia el workspace (`cleanWs`).
- `success` / `unstable` / `failure`: mensajes de estado del build.

**`options`:** timestamps en el log, timeout de 60 min, retención de los últimos 20
builds y `disableConcurrentBuilds` (evita ejecuciones concurrentes sobre la misma KB).

### Empaquetado de Deployment Units (`packageDeploymentUnit`)

Función helper que, por cada DU, ejecuta dos invocaciones de MSBuild sobre
`deploy.msbuild` de GeneXus:

1. **`CreateDeploy`** → analiza los objetos y genera el `.gxdproj` de deployment.
   Recibe `ObjectNames`, `ProjectName`, `INCLUDE_GAM`, `APPLICATION_KEY`,
   `PACKAGE_FORMAT` y —solo para `war`/`ear`— `TARGET_JRE` y `ApplicationServer`.

2. **`CreatePackage`** → sobre el `.gxdproj` generado, produce el paquete final en
   `outputDir` (`DEPLOY_TYPE="BINARIES"`, `PACKAGE_FORMAT`, `DeployFullPath`, etc.).

Parámetros de `packageDeploymentUnit(cfg)`:

| Parámetro | Obligatorio | Default | Descripción |
|---|---|---|---|
| `projectName` | sí | — | Nombre del `.gxdproj`. |
| `objectNames` | sí | — | Objetos a incluir en la DU. |
| `includeGam` | sí | — | `True` / `False`. |
| `outputDir` | sí | — | Carpeta de salida del paquete. |
| `packageFormat` | no | `Automatic` | `Automatic` \| `war` \| `ear`. |
| `dprojSubdir` | no | `web` | Subcarpeta del environment donde queda el `.gxdproj`. |

> El `.gxdproj` se busca en `KB_PATH\KB_ENVIRONMENT\<dprojSubdir>\<projectName>.gxdproj`.
> Si tu environment Java ubica el proyecto en otra subcarpeta, pasá `dprojSubdir`.

---

## Uso para .NET (comportamiento por defecto)

No requiere configuración adicional de empaquetado. Con los valores por defecto
(`*_PACKAGE_FORMAT = 'Automatic'`):

1. Ajustá las rutas, KB, credenciales y proyectos en el bloque `environment`.
2. Usá un `KB_ENVIRONMENT` correspondiente al generador .NET (ej. `ProdNet`).
3. Ejecutá el pipeline: se generan los paquetes estándar y se publican en
   `DEPLOY_TARGET`.

---

## Uso para Java (generar WAR / EAR)

1. Configurá un `KB_ENVIRONMENT` con generador Java (ej. `ProdJava`).
2. Definí el formato por DU:
   ```groovy
   FRONTEND_PACKAGE_FORMAT = 'war'
   BACKEND_PACKAGE_FORMAT  = 'war'   // o 'ear', según corresponda
   ```
3. Ajustá las propiedades Java:
   ```groovy
   TARGET_JRE = '11'
   APP_SERVER = 'Generic Servlet 6.0'
   ```
4. Si el `.gxdproj` de tu environment Java no queda bajo la subcarpeta `web`, pasá
   `dprojSubdir` en la llamada correspondiente dentro de los stages
   `Frontend DU` / `Backend DU`.
5. Ejecutá el pipeline: GeneXus generará el `.war` (o `.ear`) en `outputDir` y se
   publicará en `DEPLOY_TARGET`.

> Referencia oficial:
> [Application Deployment MSBuild tasks](https://docs.genexus.com/en/wiki?42073,Application+Deployment+MSBuild+tasks).

---

## Notas

- La generación de WAR/EAR es **opt-in**: con la configuración por defecto el pipeline
  se comporta exactamente igual que en un deploy .NET.
- El empaquetado corre íntegramente vía `deploy.msbuild` de GeneXus; el script
  `genexus-tasks.msbuild` interviene solo en el checkout (`Update`) y el build
  (`BuildAll`).
- `genexus-tasks.msbuild` incluye además targets de testing (`RunAllTests`,
  `RunTestsList`, `RecordMockingDataForTest`, `RunIOSUITests`) y de mantenimiento de la
  KB (`CheckAndCompress`), no utilizados por este pipeline pero disponibles para
  invocación manual.
