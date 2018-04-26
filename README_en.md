# Style Guide for GeneXus Development
by [Daniel Monza](https://uy.linkedin.com/in/daniel-monza-62515112)

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/80x15.png)](http://creativecommons.org/licenses/by-sa/4.0/)

## Table of Contents

  1. [Naming](#naming)
  1. [Enumerated Domains](#enumerated-domains)
  1. [Indent and Spacing](#indent-and-spacing)
  1. [Structured Data Types](#structured-data-types)
  1. [Strings](#strings)
  1. [Comments](#comments)
  1. [Commands and Functions](#commands-and-functions)
  1. [Parameters](#parameters)
  1. [Resources](#resources)
  1. [Companies that use this guide](#companies-that-use-this-guide)
  1. [Translation](#translation)
  1. [Colaboradorators](#colaboradorators)
  1. [License](#license)
  1. [Amendments](#amendments)

## Naming

  <a name="naming--descriptive"></a><a name="1.1"></a>
  - [1.1](#naming--descriptive) Names must be descriptive
	> The goal is to name stuff in a descriptive way
	
    ```javascript
    // bad
    Proc: CliCre

    // good
    Proc: ClientCreate
    ```

  <a name="naming--PascalCase"></a><a name="1.2"></a>
  - [1.2](#naming--PascalCase) Use PascalCase when naming objects,attributes and variables

    ```javascript
    // bad
    createclient

    // good
    ClientCreate
    ```

  <a name="naming--leading-underscore"></a><a name="1.3"></a>
  - [1.3](#naming--leading-underscore) Do not use underscore at the begining or end of any names for objects, attributes or variables.
    > This could misguide a programmer more familiar with other languages that theres some privacy meaning to the name.

    ```javascript
    // bad
    &_CliNam = "John Doe"
    &CliNam_ = "John Doe"
    Proc: _ClientCreate

    // good
    &ClientName = "John Doe"
    ```

  <a name="naming-enums"></a><a name="1.4"></a>
  - [1.4](#naming-enums) Enumerated domain names must start with the entity and then the type without abreviations, both in singular way. When defining a type we should be specific about the type of what. 
	> This facilitates the definition of attributes and variables based on the domain (GeneXus will do it automatically). Also it makes it easier to reuse the domain - i.e. it's not just a Document-Type is the visibility-type of the document and other things might have the same visibility types.
   

    ```javascript
    // bad
    DocumentsTypes
    DocumentsType
    DocType
    
    // good
    DocumentVisiblityType {public,private}
    TransactionAccountType {credit, debit}
    ```

  <a name="naming-procs"></a><a name="1.5"></a>
  - [1.5](#naming-procs) Name related procedures as Entity + Attribute (depending on the case) + Action  + Complement. 
	> This facilitates the selection of objects that deal with the same entity.
	Typical actions are Get, Set, Load (for an SDT), Insert, Update, Delete, etc. The difference between Set and Update is that Set refers to one attribute while Update refers to the entity 
	
    ```javascript
    // bad
    CliCre
    UpdateClient
    DateClient
    
    // good
    ClientUpsert
	ClientDelete
    ClientUpdateDateGet
    ClientUpdateDateSet
    ClientNameGet
	ClientNameSet
	ClientLoad
	DocumentRecalculate
    ```

  <a name="naming-gik"></a><a name="1.6"></a>
  - [1.6](#naming-gik) Use [GIK nomenclature](http://wiki.genexus.com/commwiki/servlet/wiki?1872,GIK) to name attributes. The use of 3 characters for the entity is recommendend when the names cannot exceed 20 characters and it has a clear and shared meaning.
	> This is the standard since the beginings of GeneXus
	
    ```javascript
    // bad
    CreCliDte
    DateCreationClient
    
    // good
    CliCreDte
    
    // Better
	ClientCreateDate or CliInsertDate
	```

  <a name="naming-trns"></a><a name="1.7"></a>
  - [1.7](#naming-trns) Transactions should be named after the entity in singular.
	> This faciliates working with [Business Component](http://wiki.genexus.com/commwiki/servlet/wiki?5846,Toc%3ABusiness+Component). and it is required by some patterns GeneXus (ie.: K2BTools).
	
    ```javascript
    // bad
    Trn:Clients
    Trn:Products
    
    // good
    Trn:Client
    Trn:Product
	```

**[Back to Top](#table-of-contents)**

## Indent and Spacing
  <a name="whitespace-tab"></a><a name="2.1"></a>
  - [2.1](#whitespace-tab) Use tabs (tab) instead of "spaces". This way each developer can visualize the space as they prefer since the number of characters in a tab can be configured in GeneXus preferences.
    > Indent faciliates reading the source code, so if we follow a standard indentation it will make it easier for other developers to follow and understand the code.

	 ```javascript
    // bad
    if &DocumentOperationType = DocumentOperationType.Sale
    msg("Sale")
    endif

    // bad
    if &DocumentOperationType = DocumentOperationType.Sale
    		msg("Sale")
    endif

    // good
    if &DocumentOperationType = DocumentOperationType.Sale
       msg("Sale")
    endif
    ```

  <a name="whitespace-where"></a><a name="2.2"></a>
  - [2.2](#whitespace-where) Indent conditions in a for-each command

	 ```javascript
    // bad
    for each
    where DocumentOperationType = DocumentOperationType.Sale
    ...
    endfor

    // bad
    for each
    defined by ClientName
    ...
    endfor

    // good
    for each
       where DocumentOperationType = DocumentOperationType.Sale
       ...
    endfor
    ```
  <a name="whitespace-newline"></a><a name="2.3"></a>
  - [2.3](#whitespace-newline) If a [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) specifies a WHERE condition, or a DEFINED command, leave a blank space before the next line

	```javascript
    // bad
    for each
       where DocumentOperationType = DocumentOperationType.Sale
       if DocumentTotalAmount > &MaxCreditAmount
          ...
       endif
    endfor

    // bad
    for each
       defined by ClientName
       for each Document
          ...
       endfor
    endfor

    // good
    for each
       where DocumentOperationType = DocumentOperationType.Sale
	   
       if DocumentTotalAmount > &MaxCreditAmount
          ...
       endif
    endfor

    // good
    for each
       defined by ClientName
       
       for each Document
          ...
       endfor
    endfor
	```
    
  <a name="whitespace-parms"></a><a name="2.4"></a>
  - [2.4](#whitespace-parms) Leave a space before each parm.

	> It makes the parm sentence more readable

	 ```javascript
    // bad
    parm(in:ClientId,out:&ClientName);

    // good
    parm( in:ClientId, out:&ClientName);
	
    // bad
    &Date = ymdtod(2017,01,01)

    // good
    &Date = ymdtod( 2017, 01, 01)
    ```

**[Back to Top](#table-of-contents)**

## Enumerated Domains
  <a name="enums-use"></a><a name="3.1"></a>
  - [3.1](#enums-use) Avoid the use of literals when there are many possible values
    > It makes the code easier to read and avoids typos and confusion

    ```javascript
    // bad
    if &HttpResponse = "GET"
    
    // good
    // Create an enumreated domain HTTPMethod with possible values ( POST, GET)
    if &HttpResponse = HTTPMethod.Get
    ```

**[Back to Top](#table-of-contents)**

## Structured Data Types
  <a name="sdt-use"></a><a name="4.1"></a>
  - [4.1](#sdt-use) Use New() when crating an SDT instead of a Clone(). Also do it before the SDT is used for the first time instead of at the end (even though GeneXus supports it)
    > It improves readibility

    ```javascript
    // &ClientCollection  is aSDT:Client [List]
    // &Client is a SDT:Cliente
    
    // bad
    for each Client
       &Client.ClientName = ClientName
       &ClientCollection.Add( &Client.Clone() )
    endfor
    
    // good
    for each Client
       &Client = new()
       &Client.ClientName = ClientName
       &ClientCollection.Add( &Client )
    endfor
    ```
  <a name="sdt-collection"></a><a name="4.1"></a>
  - [4.1](#sdt-collection) As GeneXus allows to define a variable as a collection, avoid the creation of SDT of type collection. 
    > When defining the variable of the particular item, mark it as a collection

    ```javascript
    // bad
    SDT:Clients : Collection
    	ClientItem
        	ClientNome
    
    // good
    SDT:Client
       	ClientName
    ```

**[Back to Top](#table-of-contents)**

## Strings

  <a name="strings-format"></a><a name="5.1"></a>
  - [5.1](#strings-format) Use [format](http://wiki.genexus.com/commwiki/servlet/wiki?8406,Format%20function) to display messages that contain data
    > If the application will be translated to different languages, there is no need to change the programming

    ```javascript
    // bad
    &Msg = "The client #" + &ClientId.ToString() + " is called " + &ClientName
    
    // good
    &Msg = format( "Client # %1 is called %2", &ClientId.ToString(), &ClientName)
    ```

  <a name="strings-trans"></a><a name="5.2"></a>
  - [5.2](#strings-trans) Use !"" for strings that do not need translation
    > A translator can modify constants for specific system codes that can affect the behavior (i.e. for parameters)

    ```javascript
    // bad
    &ParmVal = ParmGet( "GLOBAL ENCRYPT KEY")
    
    // good
    &ParmVal = ParmGet( !"GLOBAL ENCRYPT KEY")
    ```

**[Back to Top](#table-of-contents)**

## Comments

  <a name="comments--multiline"></a><a name="6.1"></a>
  - [6.1](#comments--multiline) Use `/** ... */` to write multi-line comments.
	
    ```javascript
    // bad
    // CreateClient creates a new client
    // parameters:
    // &ClientName
    // &ClientAddress
    sub 'CreateClient'
      // ...
    endsub
	
    // good
    /**
     * CreateClient ceates a new client
     * parameters:
     * &ClientName
     * &ClientAddress
     */
    sub 'CreateClient'
       // ...
    endsub
    ```

  <a name="comments--singleline"></a><a name="6.2"></a>
  - [6.2](#comments--singleline) Use `//` for single line comments. These comments should be in the line before the comment-target. Leave a blank line before the comment unless it is the first line of the block.

    ```javascript
    // bad
    &ClientName = "John Doe" // Assign name to the variable

    // good
    // Assign name to the variable
    &ClientName = "John Doe"

    // bad
    sub 'CrateClient'
       msg( "Creating Client", status )
       // Create Client
       &ClientBC = new()
       &ClientBC.ClientName = "John Doe"
       &ClientBC.Save()
    endsub

    // good
    sub 'CreateClient'
       msg( "Creating Client", status )
		
       // Create Client
       &ClientBC = new()
       &ClientBC.ClientName = "John Doe"
       &ClientBC.Save()
    endsub

    // this is also Ok
    sub 'CreateClient'
       // Create client
       &ClientBC = new()
       &ClientBC.ClientName = "John Doe"
       &ClientBC.Save()
    endsub
    ```
  <a name="comments--spaces"></a><a name="6.3"></a>
  - [6.3](#comments--spaces) Start comments with a space to increase readibility.

    ```javascript
    // bad
    //Is Active
    &IsActive = true

    // good
    // Is Active
    &IsActive = true

    // bad
    /**
     *Get the Company name
     *so we can display it afterwards
     */
    &CompanyName = CompanyGetName( &CompanyId)

    // good
    /**
     * Get the Company name
     * so we can display it afterwards
     */
    &CompanyName = CompanyGetName( &CompanyId)
    ```

  <a name="comments--actionitems"></a><a name="6.4"></a>
  - [6.4](#comments--actionitems) Prefix comments with `FIXME` o `TODO` help other developers to understand quickly if they are looking at a possible issue that needs review.  These are different from other comments as they are supposed to trigger future actions. Actions are `FIXME: -- needs a solution` or `TODO: -- needs implementation`.

  <a name="comments--fixme"></a><a name="6.5"></a>
  - [6.5](#comments--fixme) Use `// FIXME:` to highlight issues

    ```javascript
    // FIXME: Check when &Divisor is 0
    &Total = &Number / &Divisor
    ```

  <a name="comments--todo"></a><a name="6.6"></a>
  - [6.6](#comments--todo) Use `// TODO:` to highlight pending implementations

    ```javascript
    // TODO: Implement Sub
    Sub "CreateClient"
    Endsub
	```

**[Back to Top](#table-of-contents)**

## Commands and Functions

  <a name="commands--naming"></a><a name="7.1"></a>
  - [7.1](#commands--naming) Use lowercase when naming commands and system-functions
	> This makes development faster as commands are used frequently  and they dont need PascalCase. The only exception sometimes is Sub because it makes it more visible the start/end of the Subroutine

    ```javascript
    // bad
    for Each
       Where ClientId = &ClientId
       Msg(ClientName)
    EndFor

    // good
    for each
       where ClientId = &ClientId
       msg(ClientName)
    endfor
    
    // bad
    &Date = YmdToD( 2017, 01, 01)

    // good
    &Date = ymdtod( 2017, 01, 01)
    ```

  <a name="commands--case"></a><a name="7.2"></a>
  - [7.2](#commands--case) Use [do case](http://wiki.genexus.com/commwiki/servlet/wiki?31605,Do%20Case%20command) to substitute nested [if](http://wiki.genexus.com/commwiki/servlet/wiki?8608,If+Command,) when possible. Leave a space between each case when the sentences are complex otherwise format to maximize readibility

    ```javascript
    // bad
    if &DocumentType = DocumentOperationType.Sale
       ...
    else
   	   if &DocumentType = DocumentOperationTypes.Purchase
          ...
       endif
	endif
    
    // also bad
    do case
       case &DocumentType = DocumentOperationType.Sale
          do 'Something'
       case &DocumentType = DocumentOperationTypes.Purchase
         do 'Something Else'
          
	endcase
    
    // good
    do case
       case &DocumentType = DocumentOperationType.Sale
          do 'Something'
			
       case &DocumentType = DocumentOperationTypes.Purchase
		  do 'Something Else'
       
       otherwise
          do 'Something entirely different'
	endcase
    
	// also good - When there are many cases and the action is a one-line piece of code.
	>This facilitates read all the options without having to scroll 
    do case
       case &Action = Action.Update		do 'DoUpdate'
       case &Action = Action.Insert		do 'DoInsert'
       case &Action = Action.Regenerate	do 'DoRegenerate'
       case &Action = Action.Clean		do 'DoClean'
       case &Action = Action.Refresh	do 'DoRefresh'
       case &Action = Action.Reload		do 'DoReload'
       otherwise						do 'UnexpectedAction'
	endcase
    
	```

  <a name="commands--foreach-where"></a><a name="7.3"></a>
  - [7.3](#commands--foreach-where) Use "where" clause in [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) commands instead of "if", whenever we are dealing with [extended table](http://training.genexus.com/resumen-de-conceptos-fundamentales-de-genexus-es#tabla-base-y-tabla-extendida-resumen-de-conceptos-fundamentales) attributes.
	> The condition is solved by the DBMS and is optimized.

    ```javascript
    // bad
    for each Document
       if DocumentType = DocumentOperationType.Sales
          ...
       endif
    endfor
    
    // good
    for each
       where DocumentType = DocumentOperationType.Sales
       ...
    endfor
    ```

  <a name="commands--foreach-when"></a><a name="7.4"></a>
  - [7.4](#commands--foreach-when) Use "when" in [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) commands to simplify the sentence sent to the DBMS.

    ```javascript
    // bad
    for each Documentos
       where DocumentType = DocumentOperationType.Sales
       where DocumentDate >= &StartDate or null(&StartDate)
       ...
    endfor
    
    // good
    for each
       where DocumentType = DocumentOperationType.Sales
       where DocumentDate >= &StartDate when not &StartDate.IsEmpty()
       ...
    endfor
    ```
    
**[Back to Top](#table-of-contents)**

## Parameters

  <a name="parms--sdt"></a><a name="8.1"></a>
  - [8.1](#parms--sdt) Use an SDT instead of multiple related parameters
  > Otherwise code might be harder to read and when parameters are modified we need to review all the callers. This might not be always possible - i.e. in webpanels
  
    ```javascript
    // bad
    parm( in:&ClientName, in:&ClientLastName, in:&ClientPhone, in:&ClientAddress, in:&ClientDOB)
	  
    // good
    parm( in:&sdtClient )
    ```

**[Back to Top](#table-of-contents)**

## Resources

  - [GeneXus Wiki](http://wiki.genexus.com/) - GeneXus
  - [GeneXus Training](http://training.genexus.com) - GeneXus
  - [GeneXus Developpers](http://developers.genexus.com) - GeneXus

## Companies that use this guide

  This is a list of organizations that are using this style guide. Let us know your feedback and if you want to be added to this list (or a specific fork) and we will add you.

- [**Sincrum**](http://sincrum.com)
- [**TangoCode**](http://tangocode.com)

## Translation

This style guide is also available in other languages:

  - ![es](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Spain.png) [**Español**](README.md)

**[Back to Top](#table-of-contents)**

## Colaboradorators

  - [Laura Aguiar](https://uy.linkedin.com/in/laura-aguiar-396aa56)

## License

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](
http://creativecommons.org/licenses/by-sa/4.0/)

based on [AirBNB Javascript guide](http://airbnb.io/javascript/)

**[Back to Top](#table-of-contents)**

## Amendments

We encourage you to fork this guide and change the rules to fit your team's style guide. Below, you may list some amendments to the style guide. This allows you to periodically update your style guide without having to deal with merge conflicts.