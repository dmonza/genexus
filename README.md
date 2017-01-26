# Sincrum - Guia de estilo para el desarrollo en GeneXus

## Tabla de Contenidos

  1. [Definición de nombres](#definición-de-nombres)
  1. [Dominios enumerados](#dominios-enumerados)
  1. [Identación y espaciado](#identación-y-espaciado)
  1. [Structured Data Types](#structured-data-types)
  1. [Strings](#strings)
  1. [Comentarios](#comentarios)
  1. [Comandos y funciones](#comandos-y-funciones)
  1. [Parámetros](#parámetros)
  1. [Recursos](#recursos)
  1. [Empresas que utilizan esta guia](#empresas-que-utilizan-esta-guia)
  1. [Colaboradores](#colaboradores)
  1. [Licencia](#licencia)

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
  - [1.4](#naming-enums) Nombrar los dominios enumerados comenzando con la entidad en singular y siguiendo con el enumerado en plural sin abreviar estos.

    ```javascript
    // mal
    DocumentoTipo
    DocumentosTipos
    DocTipos
    
    // bien
    DocumentoTipos (Venta,Compra,etc)
    DocumentoModos (Credito, Débito)
    ```

  <a name="naming-procs"></a><a name="1.5"></a>
  - [1.5](#naming-procs) Nombrar procedimientos relacionados mediante Entidad + Atributo(depende el caso) + Complemento + Acción.
	> Esto permite agrupar los objetos de la misma entidad en la selección de objetos entre otros.
	
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
  - [1.7](#naming-trns) Las transacciones deben tener el nombre de la entidad en plural.
	> Las transacciones definen el nombre de las tablas en GeneXus. Se defien en plural ya que estas contienen N registros de la misma entidad.
	
    ```javascript
    // mal
    Trn:Articulo
    Trn:Cliente
    
    // bien
    Trn:Clientes
    Trn:Articulos
	```

**[Volver al inicio](#tabla-de-contenidos)**

## Identación y espaciado
  <a name="whitespace-tab"></a><a name="2.1"></a>
  - [2.1](#whitespace-tab) Utilizar tabuladores (tab) en lugar de "espacios". De esta forma, cada uno puede visializar la cantidad de espacioes que prefiera, ya que se configura en GeneXus.
    > La identación ofrece a los desarrolladores una mejor lectura del código fuente. Si tomamos una identación estandard, facilitará al resto entednder el código fuente.

	 ```javascript
    // mal
    if &DocumentoTipo = DocumentoTipos.Venta
    msg("Venta")
    endif

    // mal
    if &DocumentoTipo = DocumentoTipos.Venta
    		msg("Venta")
    endif

    // bien
    if &DocumentoTipo = DocumentoTipos.Venta
       msg("Venta")
    endif
    ```

  <a name="whitespace-where"></a><a name="2.2"></a>
  - [2.2](#whitespace-where) Se deben identar las condiciónes y comandos dentro de un for each.

	 ```javascript
    // mal
    for each
    where DocumentoTipo = DocumentoTipos.Venta
    ...
    endfor

    // mal
    for each
    defined by ClienteNombre
    ...
    endfor

    // bien
    for each
       where DocumentoTipo = DocumentoTipos.Venta
       ...
    endfor
    ```
  <a name="whitespace-newline"></a><a name="2.3"></a>
  - [2.3](#whitespace-newline) Si en un [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) se especifican where, defined by ú otros, dejar una línea en blanco antes del código.

	 ```javascript
    // mal
    for each
       where DocumentoTipo = DocumentoTipos.Venta
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
    endfor    ```

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
    // Crear un dominio enumerado HTTPMethods con los posibles valores ( POST, GET)
    if &HttpResponse = HTTPMethods.Get
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Structured Data Types
  <a name="sdt-use"></a><a name="4.1"></a>
  - [4.1](#sdt-use) Utilizar New() en la creación de SDT en lugar de Clone().
    > Queda claro que se está trabajando con un nuevo item.

    ```javascript
    // &Cliente SDT:Cliente
    // &Clientes lista de SDT:Cliente
    
    // mal
    for each Clientes
       &Cliente.CliNom = CliNom
       &Clientes.Add( &Cliente.Clone() )
    endfor
    
    // bien
    for each Clientes
       &Cliente = new()
       &Cliente.CliNom = CliNom
       &Clientes.Add( &Cliente )
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
  - [5.1](#strings-format) Utilizar [format](http://wiki.genexus.com/commwiki/servlet/wiki?8406,Format%20function) para desplegar mensajes conteniendo datos.
    > Si la aplicación se va a traducir en diferentes lenguajes no hay que re-programar los mensajes.

    ```javascript
    // mal
    &Msg = "El cliente Nro." + &CliId.ToString() + " se llama " + &CliNom
    
    // bien
    &Msg = format( "El cliente Nro. %1 se llama %2", &CliId.ToString(), &CliNom)
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

**[Volver al inicio](#tabla-de-contenidos)**

## Comentarios

  <a name="comments--multiline"></a><a name="6.1"></a>
  - [6.1](#comments--multiline) Utilizar `/** ... */` para comentarios multi-línea.
	
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
       msg( "Creando cliente", status )
       // Se crea el cliente
       &ClienteBC = new()
       &ClienteBC.CliNom = "John Doe"
       &ClienteBC.Save()
    endsub

    // bien
    sub 'CrearCliente'
       msg( "Creando cliente", status )
		
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
  - [7.1](#commands--naming) Utilizar minúsculas al nombrar comandos.
	> Esto optimiza el desarrollo ya que los comandos y funciones provistas por el lenguaje se utilizan tan frecuentemente y no es necesario especificarlos en PascalCase.

    ```javascript
    // mal
    For Each
       Where CliCod = &CliCod
       Msg(CliNom)
    EndFor

    // bien
    for each
       where CliCod = &CliCod
       msg(CliNom)
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
  - [7.4](#commands--foreach-when) Utilizar when en comandos [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) para simplificar la query enviada al DBMS.

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
    
**[Volver al inicio](#tabla-de-contenidos)**

## Parámetros

  <a name="parms--sdt"></a><a name="8.1"></a>
  - [8.1](#parms--sdt) Utilizar SDT en lugar de multiples parámetros.
  > La lectura queda confusa y cuando se modifican los parámetros hay que revisar todos los llamadores. Esto algunas veces no es posible, por ejemplo en webpanels.
  
    ```javascript
    // mal
    parm( in:&CliNom, in:&CliApe, in:&CliTel, in:&CliDir, in:&CliDOB)
	  
    // bien
    parm( in:&sdtCliente )
    ```

**[Volver al inicio](#tabla-de-contenidos)**

## Recursos

  - [GeneXus Wiki](http://wiki.genexus.com/) - GeneXus
  - [GeneXus Training](http://training.genexus.com) - GeneXus
  - [GeneXus Developpers](http://developers.genexus.com) - GeneXus

## Empresas que utilizan esta guia

  Esta es una lista de las empresas que están utilizando esta guia de desarrollo.  This is a list of organizations that are using this style guide. Haganos saber si su empresa utiliza esta guia o un fork de la misma y lo agregaremos.

- [**Sincrum**](http://sincrum.com)

## Colaboradores

  - Son bienvenidos a colaborar.

## Licencia

[Documento creado por Daniel Monza bajo licencia MIT](LICENSE)
basado en [la guia de Javascript de AirBNB](http://airbnb.io/javascript/)

**[Volver al inicio](#tabla-de-contenidos)**