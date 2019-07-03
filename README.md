# Sincrum - Guia de estilo para el desarrollo en GeneXus
por [Daniel Monza](https://uy.linkedin.com/in/daniel-monza-62515112)

[![Licencia Creative Commons](https://i.creativecommons.org/l/by-sa/4.0/80x15.png)](http://creativecommons.org/licenses/by-sa/4.0/)

Por correcciones o mejoras, pueden utilizar los [issues de github](https://github.com/sincrum/genexus/issues) o enviarlas por email a [info@sincrum.com](mailto:info@sincrum.com).

## Objetivos
La presente guía se realizó buscando los siguientes objetivos:

  1. Transmitir las mejores prácticas a la hora de desarrollar en GeneXus.
  1. Estandarizar el código escrito. Ya que hay tantas formas de programar como programadores, se intenta simplificar la lectura del código fuente.
  1. Divulgar buenas prácticas de codificación y las novedades del lenguaje.

## Tabla de Contenidos

  1. [Definición de nombres](#definición-de-nombres)
  1. [Dominios enumerados](#dominios-enumerados)
  1. [Identación y espaciado](#identación-y-espaciado)
  1. [Structured Data Types](#structured-data-types)
  1. [Strings](#strings)
  1. [Comentarios](#comentarios)
  1. [Comandos y funciones](#comandos-y-funciones)
  1. [Parámetros](#parámetros)
  1. [Subrutinas](#subrutinas)
  1. [Buenas prácticas](#buenas-prácticas)
  1. [Recursos](#recursos)
  1. [Empresas que utilizan esta guia](#empresas-que-utilizan-esta-guia)
  1. [Traducciones](#traducciones)
  1. [Licencia](#licencia)
  1. [Modificaciones al documento](#modificaciones-al-documento)

## Definición de nombres

  <a name="naming--descriptive"></a><a name="1.1"></a>
  - [1.1](#naming--descriptive) Se debe ser descriptivo con los nombres.
	> Se intenta que el nombre sea autodescriptivo.

    ```javascript
    // mal
    Proc: CliCre

    // bien
    Proc: ClienteCrear
    ```

  <a name="naming--PascalCase"></a><a name="1.2"></a>
  - [1.2](#naming--PascalCase) Utilizar PascalCase al nombrar objetos, atributos y variables.

    ```javascript
    // mal
    clientecrear

    // bien
    ClienteCrear
    ```

  <a name="naming--leading-underscore"></a><a name="1.3"></a>
  - [1.3](#naming--leading-underscore) No utilizar underscore al inicio o final en ningún tipo de objeto, atributo o variable.
    > Esto puede hacer suponer a un programador proveniente de otros lenguajes que tiene algún significado de privacidad.

    ```javascript
    // mal
    &_CliNom = "John Doe"
    &CliNom_ = "John Doe"
    Proc: _ClienteCrear

    // bien
    &CliNom = "John Doe"
    ```

  <a name="naming-enums"></a><a name="1.4"></a>
  - [1.4](#naming-enums) Nombrar los dominios enumerados sin abreviar, comenzando con la entidad en singular y siguiendo con el calificador enumerado también en singular. Los valores enumerados también se deben especificar en singular.
	> Esto es para facilitar la definición de atributos y variables basadas en un dominio (GeneXus lo hará automáticamente).

    ```javascript
    // mal
    DocumentosTipo
    DocumentosTipos
    DocTipos

    // bien
    DocumentoTipo { Venta, Compra, etc}
    DocumentoModo { Credito, Débito}
    ```

  <a name="naming-procs"></a><a name="1.5"></a>
  - [1.5](#naming-procs) Nombrar procedimientos relacionados mediante Entidad + Atributo(depende el caso) + Complemento + Acción.
	> Esto permite agrupar los objetos de la misma entidad en la selección de objetos entre otros. Algunas acciones típicas son Get, Set, Load (para SDT), Insert, Utpdate, Delete, etc. La diferencia entre Set y Update es que Set refiere a un atributo y Update a una entidad.

    ```javascript
    // mal
    CreCli
    UpsertCliente
    FechaCliente

    // bien
    ClienteUpsert
	ClienteEliminar
    ClienteFechaModificadoGet
    ClienteFechaModificadoSet
	DocumentoRecalculo
	```

  <a name="naming-gik"></a><a name="1.6"></a>
  - [1.6](#naming-gik) Utilizar [nomenclatura GIK](http://wiki.genexus.com/commwiki/servlet/wiki?1872,GIK) para nombrar atributos. Se pueden crear atributos sin el límite de los 3 caracteres si el nombre no supera los 20 caracteres y mejora la comprensión.
	> Estandard desde los inicios de GeneXus.

    ```javascript
    // mal
    CreCliFch
    FechaCreadoCliente

    // bien
    CliFchCre

    // mejor
    ClienteFechaCreado
	```

  <a name="naming-trns"></a><a name="1.7"></a>
  - [1.7](#naming-trns) Las transacciones deben tener el nombre de la entidad en singular.
	> Se define así porque en la comunidad GeneXus está claro que queda mejor a la hora de trabaja por ejmeplo con [Business Component](http://wiki.genexus.com/commwiki/servlet/wiki?5846,Toc%3ABusiness+Component). También es requerimiento de algunos patterns GeneXus para su correcta visualización (ej.: K2BTools).

    ```javascript
    // mal
    Trn:Articulos
    Trn:Clientes

    // bien
    Trn:Cliente
    Trn:Articulo
	```

**[Volver al inicio](#tabla-de-contenidos)**

## Identación y espaciado
  <a name="whitespace-tab"></a><a name="2.1"></a>
  - [2.1](#whitespace-tab) Utilizar tabuladores (tab) en lugar de "espacios". De esta forma, cada uno puede visializar la cantidad de espacioes que prefiera, ya que se configura en GeneXus.
    > La identación ofrece a los desarrolladores una mejor lectura del código fuente. Si tomamos una identación estandard, facilitará al resto entednder el código fuente.

	 ```javascript
    // mal
    if &DocumentoTipo = DocumentoTipos.Venta
    msg( "Venta")
    endif

    // mal
    if &DocumentoTipo = DocumentoTipo.Venta
    		msg( "Venta")
    endif

    // bien
    if &DocumentoTipo = DocumentoTipo.Venta
        msg( "Venta")
    endif
    ```

  <a name="whitespace-where"></a><a name="2.2"></a>
  - [2.2](#whitespace-where) Se deben identar las condiciónes y comandos dentro de un for each.

	 ```javascript
    // mal
    for each
    where DocumentoTipo = DocumentoTipo.Venta
    ...
    endfor

    // mal
    for each
    defined by ClienteNombre
    ...
    endfor

    // bien
    for each
        where DocumentoTipo = DocumentoTipo.Venta

        ...
    endfor
    ```
  <a name="whitespace-newline"></a><a name="2.3"></a>
  - [2.3](#whitespace-newline) Si en un [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) se especifican where, defined by ú otros, dejar una línea en blanco antes del código.

	```javascript
    // mal
    for each
       where DocumentoTipo = DocumentoTipo.Venta
       if DocTot > LimCreMto
          ...
       endif
    endfor

    // mal
    for each
       defined by ClienteNombre
       for each Documentos
          ...
       endfor
    endfor

    // bien
    for each
       where DocumentoTipo = DocumentoTipos.Venta

       if DocTot > LimCreMto
          ...
       endif
    endfor

    // bien
    for each
       defined by ClienteNombre

       for each Documentos
          ...
       endfor
    endfor
	```

  <a name="whitespace-parms"></a><a name="2.4"></a>
  - [2.4](#whitespace-parms) Dejar un espacio antes de cada parámetro.

	> Hace a la sentencia más sencilla de leer.

	 ```javascript
    // mal
    parm(in:PaiId,out:&PaiNom);

    // bien
    parm( in:PaiId, out:&PaiNom);

    // mal
    &Fecha = ymdtod(2017,01,01)

    // bien
    &Fecha = ymdtod( 2017, 01, 01)
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Dominios enumerados
  <a name="enums-use"></a><a name="3.1"></a>
  - [3.1](#enums-use) Evitar la utilización de textos/números fijos cuando pueden existir multiples valores.
    > Simplificar la lectura y no necesitar recordar el texto específico de cada opción.

    ```javascript
    // mal
    if &HttpResponse = "GET"

    // bien
    // Crear un dominio enumerado HTTPMethod con los posibles valores ( POST, GET)
    if &HttpResponse = HTTPMethod.Get
    ```

  <a name="enums-use"></a><a name="3.2"></a>
  - [3.2](#enums-datatype) Los dominios enumerados cuyo valor quedará registrado en la base de datos, deberán ser de tipo CHAR.
      > Es para facilitar la lectura de las consultas realizadas directamente a la base de datos por el usuario. Es preferible que se utilice CHAR(2 a 3) para optimizar búsqueda mediante índices pequeños.

	```javascript
	// mal
	MovimientoCuenta.Credito 1
	MovimientoCuenta.Debito  2

	// bien
	MovimientoCuenta.Credito "CRE"
	MovimientoCuenta.Debito  "DEB"
	```

  <a name="enums-default"></a><a name="3.3"></a>
  - [3.3](#enums-default) Evitar definir dominios enumerados con valores "Empty" (0 ó "").
      > Luego, por ejemplo, si los queremos desplegar en un combo, no va a funcionar "Empty item".

	```javascript
	// mal
	ModoLectura.Normal     ""
	ModoLectura.Secuencial "S"

	// bien
	ModoLectura.Normal     "N"
	ModoLectura.Secuencial "S"
	```

**[Volver al inicio](#tabla-de-contenidos)**

## Structured Data Types
  <a name="sdt-use"></a><a name="4.1"></a>
  - [4.1](#sdt-use) Utilizar New() en la creación de SDT en lugar de Clone(). Incluso antes de utilizar el SDT por primera vez en lugar de al final (aunque GeneXus lo soporte).
    > Queda claro que se está trabajando con un nuevo item.

    ```javascript
    // &Cliente SDT:Cliente
    // &Clientes lista de SDT:Cliente

    // mal
    for each Clientes
       &Cliente.CliNom = CliNom
       &Clientes.Add( &Cliente.Clone())
    endfor

    // bien
    for each Clientes
       &Cliente = new()
       &Cliente.CliNom = CliNom
       &Clientes.Add( &Cliente)
    endfor
    ```
  <a name="sdt-list"></a><a name="4.1"></a>
  - [4.1](#sdt-list) Desde que GeneXus permite definir variables como listas, evitar crear SDT del tipo lista.
    > Al definir la variable del item particular, se lo marca como lista.

    ```javascript
    // mal
    SDT:Clientes : Lista
    	ClienteItem
        	CliNom

    // bien
    SDT:Cliente
       	CliNom
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Strings

  <a name="strings-format"></a><a name="5.1"></a>
  - [5.1](#strings-format) Utilizar [format](http://wiki.genexus.com/commwiki/servlet/wiki?8406,Format%20function) para desplegar mensajes conteniendo datos y en llamadas a funciones javascript.
    > Si la aplicación se va a traducir en diferentes lenguajes no hay que re-programar los mensajes.

    ```javascript
    // mal
    &Msg = "El cliente Nro." + &CliId.ToString() + " se llama " + &CliNom

    // bien
    &Msg = format( "El cliente Nro. %1 se llama %2", &CliId.ToString(), &CliNom)
    ```

	Esto soluciona la traducción según contexto. Por ejemplo,

	```
	ingles: "The name of John's dog is Gandalf"

	español: "El nombre del perro de John es Gandalf"
	```

	Lo anterior realizado mediante concatenación no quedaría correctamnete traducido.

	En el siguiente caso, podemos ver como podemos dejar para traducir solo el texto dentro de un método jsevent.

	```javascript
	// mal
	&Msg = "confirm('¿Está seguro de agregar excepción?')"
    &LstExc.JSEvent( "onclick", &Msg)

	// bien
	&Msg = format( !"confirm('%1')", "¿Está seguro de agregar excepción?")
    &LstExc.JSEvent( "onclick", &Msg)

	```

  <a name="strings-trans"></a><a name="5.2"></a>
  - [5.2](#strings-trans) Utilizar !"" para strings que no deben ser traducidos.
    > Un traductor puede modificar constantes o códigos específicos del sistema y pueden afectar el funcionamiento, por ejemplo parámetros.

    ```javascript
    // mal
    &ParVal = ParamGet( "GLOBAL ENCRYPT KEY")

    // bien
    &ParVal = ParamGet( !"GLOBAL ENCRYPT KEY")
    ```
  <a name="strings-quotation"></a><a name="5.3"></a>
  - [5.3](#strings-trans) Utilizar comilla doble por defecto.
    > Estandarización de código para facilitar la lectura.

	 ```javascript
    // mal
    &Msg = 'Hola mundo!'

    // bien
    &Msg = "Hola mundo!"
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Comentarios

  <a name="comments--multiline"></a><a name="6.1"></a>
  - [6.1](#comments--multiline) Utilizar `/** ... */` para comentarios multi-línea en descripciones de funcionamiento. Se puede seguir utilizando `//` ya qeu Genexus permite auto-comentar con Ctrl-Q | Ctrl-Shift-Q.

    ```javascript
    // mal
    // CrearCliente crea una nuevo cliente
    // según las variables:
    // &CliNom
    // &CliDir
    sub 'CrearCliente'
      // ...
    endsub

    // bien
    /**
     * CrearCliente crea una nuevo cliente
     * según las variables:
     * &CliNom
     * &CliDir
     */
    sub 'CrearCliente'
       // ...
    endsub
    ```

  <a name="comments--singleline"></a><a name="6.2"></a>
  - [6.2](#comments--singleline) Utilizar `//` para comentarios de una sola línea. Estos comentarios deben estar una línea antes del sujeto a comentar. Dejar una línea en blanco antes del comentarios a no ser que seal la pimer línea del bloque.

    ```javascript
    // mal
    &CliNom = "John Doe" // Se asigna el nombre a la variable

    // bien
    // Se asigna el nombre a la variable
    &CliNom = "John Doe"

    // mal
    sub 'CrearCliente'
       msg( "Creando cliente", status)
       // Se crea el cliente
       &ClienteBC = new()
       &ClienteBC.CliNom = "John Doe"
       &ClienteBC.Save()
    endsub

    // bien
    sub 'CrearCliente'
       msg( "Creando cliente", status)

       // Se crea el cliente
       &ClienteBC = new()
       &ClienteBC.CliNom = "John Doe"
       &ClienteBC.Save()
    endsub

    // también está bien
    sub 'CrearCliente'
       // Se crea el cliente
       &ClienteBC = new()
       &ClienteBC.CliNom = "John Doe"
       &ClienteBC.Save()
    endsub
    ```
  <a name="comments--spaces"></a><a name="6.3"></a>
  - [6.3](#comments--spaces) Comenzar todos los comentarios con un espacio para que sean sencillos de leer.

    ```javascript
    // mal
    //Está activo
    &IsActive = true

    // bien
    // Está activo
    &IsActive = true

    // mal
    /**
     *Se obtiene el nombre de la empresa
     *para luego desplegarlo
     */
    &EmpNom = EmpresaNombreGet( &EmpId)

    // bien
    /**
     * Se obtiene el nombre de la empresa
     * para luego desplegarlo
     */
    &EmpNom = EmpresaNombreGet( &EmpId)
    ```

  <a name="comments--actionitems"></a><a name="6.4"></a>
  - [6.4](#comments--actionitems) Agregar pefijos en los comentarios con `FIXME` o `TODO` ayudan a otros desarrolladores a entender rapidamente si se está ante un posible problema que necesita ser revisado o si se está sugiriendo una solución a un problema existente. Estos son diferentes a los comentarios regulares porque conllevan a acciones. Estas acciones son `FIXME: -- necesita resolverse` or `TODO: -- necesita implementarse`.

  <a name="comments--fixme"></a><a name="6.5"></a>
  - [6.5](#comments--fixme) Usar `// FIXME:` para marcar problemas.

    ```javascript
    // FIXME: Revisar cuando &Divisor es 0
    &Total = &Dividendo / &Divisor
    ```

  <a name="comments--todo"></a><a name="6.6"></a>
  - [6.6](#comments--todo) Usar `// TODO:` para marcar implementaciones a realizar.

    ```javascript
    // TODO: Implementar la subrutina
    sub "CrearCliente"
    endsub
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Comandos y funciones

  <a name="commands--naming"></a><a name="7.1"></a>
  - [7.1](#commands--naming) Utilizar minúsculas al nombrar comandos y funciones del sistema.
	> Esto optimiza el desarrollo ya que los comandos y funciones provistas por el lenguaje se utilizan tan frecuentemente y no es necesario especificarlos en PascalCase.

    ```javascript
    // mal
    For Each
       Where CliCod = &CliCod
       Msg( CliNom)
    EndFor

    // bien
    for each
       where CliCod = &CliCod

       msg( CliNom)
    endfor

    // mal
    &Fecha = YmdToD( 2017, 01, 01)

    // bien
    &Fecha = ymdtod( 2017, 01, 01)
    ```

  <a name="commands--case"></a><a name="7.2"></a>
  - [7.2](#commands--case) Utilizar [do case](http://wiki.genexus.com/commwiki/servlet/wiki?31605,Do%20Case%20command) siempre que se pueda a fín de sustituir [if](http://wiki.genexus.com/commwiki/servlet/wiki?8608,If+Command,) anidados. Dejar un espacio entre cada bloque de case.

    ```javascript
    // mal
    if &DocTipo = DocumentoTipos.Venta
       ...
    else
   	   if &DocTipo = DocumentoTipos.Compra
          ...
       endif
	endif

    // también mal
    do case
       case &DocTipo = DocumentoTipos.Venta
          ...
       case &DocTipo = DocumentoTipos.Compra
          ...

	endcase

    // bien
    do case
       case &DocTipo = DocumentoTipos.Venta
          ...

       case &DocTipo = DocumentoTipos.Compra
          ...

       otherwise
          ...
	endcase

    // también está bien - Cuando existen multiples case y la acción es de una sola línea.
	> Esto facilita leer todas las opciones sin necesidad de scroll
    do case
       case &Action = Action.Update      do 'DoUpdate'
       case &Action = Action.Insert      do 'DoInsert'
       case &Action = Action.Regenerate  do 'DoRegenerate'
       case &Action = Action.Clean       do 'DoClean'
       case &Action = Action.Refresh     do 'DoRefresh'
       case &Action = Action.Reload      do 'DoReload'
       otherwise	do 'UnexpectedAction'
	endcase
    ```

  <a name="commands--foreach-where"></a><a name="7.3"></a>
  - [7.3](#commands--foreach-where) Utilizar clausula where en comandos [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) en lugar de usar comandos "if", siempre que se trate de atributos de la [tabla extendida](http://training.genexus.com/resumen-de-conceptos-fundamentales-de-genexus-es#tabla-base-y-tabla-extendida-resumen-de-conceptos-fundamentales).
	> Con esto logramos trasladar la condición al DBMS y hacer que forme parte de la query select evitando trabajar con grandes volumenes de datos en el servidor de aplicación ó eventualmente en el cliente.

    ```javascript
    // mal
    for each Documentos
       if DocTipo = DocumentoTipos.Ventas
          ...
       endif
    endfor

    // bien
    for each
       where DocTipo = DocumentoTipos.Ventas
       ...
    endfor
    ```

  <a name="commands--foreach-when"></a><a name="7.4"></a>
  - [7.4](#commands--foreach-when) Utilizar "when" en comandos [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) para simplificar la query enviada al DBMS.

    ```javascript
    // mal
    for each Documentos
       where DocTipo = DocumentoTipos.Ventas
       where DocFch >= &FchIni or null(&FchIni)
       ...
    endfor

    // bien
    for each
       where DocTipo = DocumentoTipos.Ventas
       where DocFch >= &FchIni when not &FchIni.IsEmpty()

       ...
    endfor
    ```

  <a name="commands--foreach-when"></a><a name="7.5"></a>
  - [7.4](#commands--syntax) Utilizar la última sintaxis siempre que la versión lo soporte.

    ```javascript
    // mal
	&Name = udp( PNameGet, &Id)
	
	// bien
	&Name = PNameGet( &Id )
	
	// mal
    call( PNameSet, &Id, &Name)
	
	// bien
    PNameSet( &Id, &Name)
	
	// mal
	&Num = val( &NumChar)
	
	// bien
	&Num = &NumChar.ToNumeric()
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Parámetros

  <a name="parms--sdt"></a><a name="8.1"></a>
  - [8.1](#parms--sdt) Utilizar SDT en lugar de multiples parámetros.
	> Esto es importante en los casos de objetos con varios parámtros in o out, ya que la lectura queda confusa y si hay que modificar parámetros, se deberá revisar todos los llamadores. Si hay varios parámetros de salida, se debrán crear SDT por separado, tanto para entrada como para salida.

    ```javascript
	 // mal
	 parm( in:&CliNom, in:&CliApe, in:&CliTel, in:&CliDir, in:&CliDOB);

	 // bien
	 parm( in:&sdtCliente);

	 // Ejemplo de un webservice
	 // mal
	 parm( in:&Nombre, in:&Edad, in:&EstadoCivil, out:&Id, out:&ErrorId);

	 // bien
	 parm( in:&PersonCreateRequest, out:&PersonCreateResponse);
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Subrutinas

  <a name="subs--title"></a><a name="9.1"></a>
  - [9.1](#parms--title) Al definir subrutinas agregar el nombre como comentario en la misma línea.
  > Con esto logramos ver el nombre de las sub-rutinas al momento de colapsar las mismas.

  ```javascript
   // mal
   sub 'CrearCliente'
      ...
   endsub

   Resultado: "+Sub Block"

   // bien
   sub 'CrearCliente' // Crear Cliente
      ...
   endsub

   Resultado: "+Sub Block ('Crear Cliente')"
  ```

**[Volver al inicio](#tabla-de-contenidos)**

## Buenas prácticas

  <a name="bpractices--ver"></a><a name="10.1"></a>
  - [10.1](#bpractices--ver) Versionar el sistema según xx.yy.zz.

  Donde:
	- xx: Cambios mayor de versión del sistema. Cambia con una frecuencia no menor a un año y generalmente implica un cambio mayor en el  sistema.
	- yy: Incorpora cambios en base de datos.
	- zz: Incorpora solo cambios en los binarios.

  <a name="bpractices--ver"></a><a name="10.2"></a>
  - [10.2](#bpractices--ver) Disponer de la versión actual de la aplicación dentro de los binarios.
	> Esto permite de forma inequivoca saber en que versión de la aplicación estamos trabajando. La versión se puede guardar también como un parámtetro dentro de la base de datos, para poder obtener la diferencia con la versión de los binarios y así realizar la acción deseada.

	Para lograr esto, se crea un procedimiento que retorna la versión en que estamos trabajando:

	```javascript
	// Parameters
	parm( out:&Version)

	// Source
	&Version = !"1.05.06"
	```

  <a name="bpractices--defpro"></a><a name="10.3"></a>
  - [10.3](#bpractices--defpro) Propiedades por defecto

  Isolation level: Read commited  
  Generate prompt programs: No

  <a name="bpractices--pass"></a><a name="10.4"></a>
  - [10.4](#bpractices--pass) No mostrar contraseñas en logs e información de debug
	> Esto obedece a mejorar la seguridad de los sistemas, evitando que queden credenciales en archivos y consolas con sus potenciales riesgos de seguridad

  <a name="bpractices--sdt"></a><a name="10.5"></a>
  - [10.5](#bpractices--sdt) Establecer namespaces específicos en SDTs utilizados en webservices
	> Esto evita que se generen inconvenientes en producción si el environment cambia de namespace por defecto. Esto se define en la propiedad "name space" del SDT.

  <a name="bpractices--grids"></a><a name="10.6"></a>
  - [10.6](#bpractices--grids) Evitar cargar grillas por defecto
	> En la mayoría de los casos el usuario va a aplicar algún filtro y al cargar por defecto se desperdician recursos del DBMS.

<a name="bpractices--null"></a><a name="10.7"></a>
  - [10.7](#bpractices--null) Evaluar si crear atributos nuevos como "null"
	> Ayuda a no re-crear la tabla ante una Reorg. Especialmente en tablas grandes donde el tiempo de migración de datos puede ser demasiado largo. 

<a name="bpractices--session"></a><a name="10.8"></a>
  - [10.8](#bpractices--null) Evitar acceder a sesiones (websession) desde procedimientos con lógica de negocios.
	> El acceso a sesiones debe ser responsabilidad de la interfaz. Al trabajar con sesiones dentro de procedimietos estamos introduciendo lógica de la interfaz en el dominio del problema. Debido a esto, depues podemos tener problemas si deseamos utilizar dichos procedimietnos en ejecuciones por consola batch o win.

<a name="bpractices--business"></a><a name="10.9"></a>
  - [10.9](#bpractices--business) No mantener lógica del negocio en la interfaz.
	> Siguiendo con la idea anterior, se debe evitar incoporar lógica de negocios en la interfaz.
  El caso más claro en web es generar la exportación a excel y reportes en webpanels. Si en lugar de ello, los encapsulamos en procedimientos, eventualmente los podemos generar desde otras interfaces.

## Recursos

  - [GeneXus Wiki](http://wiki.genexus.com/) - GeneXus
  - [GeneXus Training](http://training.genexus.com) - GeneXus
  - [GeneXus Developpers](http://developers.genexus.com) - GeneXus
  - [GeneXus Marketplace](http://marketplace.genexus.com) - GeneXus
  - [GeneXus Search](http://search.genexus.com/) - GeneXus
  - [Stackoverflow](https://es.stackoverflow.com/questions/tagged/genexus)

## Empresas que utilizan esta guia

  Esta es una lista de las empresas que están utilizando esta guia de desarrollo. Haganos saber si su empresa utiliza esta guía ([info@sincrum.com](mailto:info@sincrum.com)) o un fork de la misma y lo agregaremos.

- [**Sincrum**](http://sincrum.com)
- [**Tangocode**](http://tangocode.com)
- [**GeneXus**](https://www.genexus.com)
- [**TributApp**](https://www.tributapp.com)
- [**I+Dev**](http://www.imasdev.com)
- [**Big Cheese**](http://bigcheese.com.uy)


**[Volver al inicio](#tabla-de-contenidos)**

## Traducciones
Esta guia de estilo se encuentra también en los siguientes lenguajes:

  - ![us](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/United-States.png) [**English**](README_en.md) by [Laura Aguiar](https://uy.linkedin.com/in/laura-aguiar-396aa56)

**[Volver al inicio](#tabla-de-contenidos)**

## Licencia
[![Licencia Creative Commons](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

Esta obra está bajo una Licencia [Creative Commons Atribución-CompartirIgual 4.0 Internacional](http://creativecommons.org/licenses/by-sa/4.0/)

Basado en [la guia de Javascript de AirBNB](http://airbnb.io/javascript/)

**[Volver al inicio](#tabla-de-contenidos)**

## Modificaciones al documento

Recomendamos que ralice un fork de está guía, realice modificaciones y/o cambie las reglas para que se adecuén a su equipo de trabajo ó empresa. A continuación puede agregar modificaciones a la guía de estilos. Esto le permite actualizar periódicamente el docuemnto sin lidiar con problemas de merge.
