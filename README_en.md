# Style Guide for GeneXus Development
by [Daniel Monza](https://uy.linkedin.com/in/daniel-monza-62515112)

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/80x15.png)](http://creativecommons.org/licenses/by-sa/4.0/)

For corrections or improvements, please use the [github issues](https://github.com/sincrum/genexus/issues) or email us at [info@sincrum.com](mailto:info@sincrum.com). If you are going to submit a change, please read the [contributing guide](CONTRIBUTING.md) first.

Published changes are recorded in the [changelog](CHANGELOG.md), and proposed rules not yet incorporated in the [roadmap](ROADMAP.md).

## Objectives
This guide was written with the following objectives in mind:

  1. Convey best practices for GeneXus development.
  1. Standardize the code that is written. Since there are as many ways to program as there are programmers, we try to make the source code easier to read.
  1. Spread good coding practices and the new features of the language.

## Table of Contents

  1. [Naming](#naming)
  1. [Enumerated Domains](#enumerated-domains)
  1. [Indent and Spacing](#indent-and-spacing)
  1. [Structured Data Types](#structured-data-types)
  1. [Strings](#strings)
  1. [Comments](#comments)
  1. [Commands and Functions](#commands-and-functions)
  1. [Parameters](#parameters)
  1. [Subroutines](#subroutines)
  1. [Good Practices](#good-practices)
  1. [Resources](#resources)
  1. [Companies that use this guide](#companies-that-use-this-guide)
  1. [Translation](#translation)
  1. [Collaborators](#collaborators)
  1. [License](#license)
  1. [Amendments](#amendments)

## Naming

  <a name="naming--descriptive"></a><a name="1.1"></a>
  - [1.1](#naming--descriptive) Names must be descriptive.
	> The goal is to name things in a self-descriptive way.

    ```javascript
    // bad
    Proc: CliCre

    // good
    Proc: ClientCreate
    ```

  <a name="naming--PascalCase"></a><a name="1.2"></a>
  - [1.2](#naming--PascalCase) Use PascalCase when naming objects, attributes and variables.

    ```javascript
    // bad
    clientcreate

    // good
    ClientCreate
    ```

  <a name="naming--leading-underscore"></a><a name="1.3"></a>
  - [1.3](#naming--leading-underscore) Do not use an underscore at the beginning or end of any object, attribute or variable name.
    > This could misguide a programmer more familiar with other languages into assuming the name has some privacy meaning.

    ```javascript
    // bad
    &_ClientName = "John Doe"
    &ClientName_ = "John Doe"
    Proc: _ClientCreate

    // good
    &ClientName = "John Doe"
    ```

  <a name="naming-enums"></a><a name="1.4"></a>
  - [1.4](#naming-enums) Name enumerated domains without abbreviating, starting with the entity in singular and then the enumerated qualifier in plural. Enumerated values must be specified in singular.
	> This is done so that attributes don't collide with enumerated domains.

    ```javascript
    // bad
    DocumentType
    DocumentsType
    DocumentsTypes
    DocTypes

    // good
    DocumentTypes { Sale, Purchase, etc}
    DocumentModes { Credit, Debit}
    ```

  <a name="naming-procs"></a><a name="1.5"></a>
  - [1.5](#naming-procs) Name related procedures as Entity + Attribute (depending on the case) + Complement + Action.
	> This makes it possible to group objects of the same entity in the object selection, among other things. Typical actions are Get, Set, Load (for an SDT), Insert, Update, Delete, etc. The difference between Set and Update is that Set refers to an attribute while Update refers to an entity.

    ```javascript
    // bad
    CreCli
    UpsertClient
    DateClient

    // good
    ClientUpsert
	ClientDelete
    ClientModifiedDateGet
    ClientModifiedDateSet
	DocumentRecalculate
    ```

  <a name="naming-gik"></a><a name="1.6"></a>
  - [1.6](#naming-gik) Use [GIK nomenclature](http://wiki.genexus.com/commwiki/servlet/wiki?1872,GIK) to name attributes. Attributes may be created without the 3-character limit if the name does not exceed 20 characters and it improves comprehension.
	> This has been the standard since the beginnings of GeneXus.

    ```javascript
    // bad
    CreCliDte
    DateCreatedClient

    // good
    CliCreDte

    // better
    ClientCreatedDate
	```

  <a name="naming-trns"></a><a name="1.7"></a>
  - [1.7](#naming-trns) Transactions should be named after the entity in singular.
	> This is defined this way because in the GeneXus community it is clear that it works better, for example when working with [Business Component](http://wiki.genexus.com/commwiki/servlet/wiki?5846,Toc%3ABusiness+Component). It is also required by some GeneXus patterns for their correct display (e.g. K2BTools).

    ```javascript
    // bad
    Trn:Products
    Trn:Clients

    // good
    Trn:Client
    Trn:Product
	```

**[Back to Top](#table-of-contents)**

## Indent and Spacing
  <a name="whitespace-tab"></a><a name="2.1"></a>
  - [2.1](#whitespace-tab) Use tabs instead of "spaces". This way each developer can visualize the number of spaces they prefer, since it is configured in GeneXus.
    > Indentation gives developers a better reading of the source code. If we adopt a standard indentation, it makes it easier for everyone else to understand the source code.

    ```javascript
    // bad
    if &DocumentType = DocumentTypes.Sale
    msg( "Sale")
    endif

    // bad
    if &DocumentType = DocumentTypes.Sale
    		msg( "Sale")
    endif

    // good
    if &DocumentType = DocumentTypes.Sale
        msg( "Sale")
    endif
    ```

  <a name="whitespace-where"></a><a name="2.2"></a>
  - [2.2](#whitespace-where) Indent the conditions and commands inside a for each.

    ```javascript
    // bad
    for each
    where DocumentType = DocumentTypes.Sale
    ...
    endfor

    // bad
    for each
    defined by ClientName
    ...
    endfor

    // good
    for each
        where DocumentType = DocumentTypes.Sale

        ...
    endfor
    ```

  <a name="whitespace-newline"></a><a name="2.3"></a>
  - [2.3](#whitespace-newline) If a [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) specifies a where, defined by, or others, leave a blank line before the code.

    ```javascript
    // bad
    for each
       where DocumentType = DocumentTypes.Sale
       if DocumentTotalAmount > MaxCreditAmount
          ...
       endif
    endfor

    // bad
    for each
       defined by ClientName
       for each Documents
          ...
       endfor
    endfor

    // good
    for each
       where DocumentType = DocumentTypes.Sale

       if DocumentTotalAmount > MaxCreditAmount
          ...
       endif
    endfor

    // good
    for each
       defined by ClientName

       for each Documents
          ...
       endfor
    endfor
	```

  <a name="whitespace-parms"></a><a name="2.4"></a>
  - [2.4](#whitespace-parms) Leave a space before each parameter.

	> It makes the sentence easier to read.

    ```javascript
    // bad
    parm(in:CountryId,out:&CountryName);

    // good
    parm( in:CountryId, out:&CountryName);

    // bad
    &Date = ymdtod(2017,01,01)

    // good
    &Date = ymdtod( 2017, 01, 01)
    ```

**[Back to Top](#table-of-contents)**

## Enumerated Domains
  <a name="enums-use"></a><a name="3.1"></a>
  - [3.1](#enums-use) Avoid the use of fixed literals/numbers when there can be multiple values.
    > It simplifies reading and removes the need to remember the specific text of each option.

    ```javascript
    // bad
    if &HttpResponse = "GET"

    // good
    // Create an enumerated domain HTTPMethod with the possible values ( POST, GET)
    if &HttpResponse = HTTPMethod.Get
    ```

  <a name="enums-datatype"></a><a name="3.2"></a>
  - [3.2](#enums-datatype) Enumerated domains whose value will be stored in the database should be of type CHAR.
      > This makes it easier to read the queries the user runs directly against the database. It is preferable to use CHAR(2 to 3) to optimize searches through small indexes.

    ```javascript
    // bad
    AccountMovement.Credit 1
    AccountMovement.Debit  2

    // good
    AccountMovement.Credit "CRE"
    AccountMovement.Debit  "DEB"
    ```

  <a name="enums-default"></a><a name="3.3"></a>
  - [3.3](#enums-default) Avoid defining enumerated domains with "Empty" values (0 or "").
      > For example, if we later want to display them in a combo, the "Empty item" will not work.

    ```javascript
    // bad
    ReadMode.Normal     ""
    ReadMode.Sequential "S"

    // good
    ReadMode.Normal     "N"
    ReadMode.Sequential "S"
    ```

**[Back to Top](#table-of-contents)**

## Structured Data Types
  <a name="sdt-use"></a><a name="4.1"></a>
  - [4.1](#sdt-use) Use New() when creating an SDT instead of Clone(). Do it even before using the SDT for the first time rather than at the end (even though GeneXus supports it).
    > It makes it clear that we are working with a new item.

    ```javascript
    // &Client SDT:Client
    // &Clients list of SDT:Client

    // bad
    for each Clients
       &Client.ClientName = ClientName
       &Clients.Add( &Client.Clone())
    endfor

    // good
    for each Clients
       &Client = new()
       &Client.ClientName = ClientName
       &Clients.Add( &Client)
    endfor
    ```

  <a name="sdt-list"></a><a name="4.2"></a>
  - [4.2](#sdt-list) Since GeneXus allows defining variables as lists, avoid creating SDTs of the list type.
    > When defining the variable of the particular item, mark it as a list.

    ```javascript
    // bad
    SDT:Clients : List
    	ClientItem
        	ClientName

    // good
    SDT:Client
       	ClientName
    ```

**[Back to Top](#table-of-contents)**

## Strings

  <a name="strings-format"></a><a name="5.1"></a>
  - [5.1](#strings-format) Use [format](http://wiki.genexus.com/commwiki/servlet/wiki?8406,Format%20function) to display messages that contain data and in calls to javascript functions.
    > If the application is going to be translated into different languages, there is no need to re-program the messages.

    ```javascript
    // bad
    &Msg = "Client #" + &ClientId.ToString() + " is called " + &ClientName

    // good
    &Msg = format( "Client # %1 is called %2", &ClientId.ToString(), &ClientName)
    ```

	This solves translation according to context. For example,

	```
	english: "The name of John's dog is Gandalf"

	spanish: "El nombre del perro de John es Gandalf"
	```

	The above, done through concatenation, would not be translated correctly.

	In the following case, we can see how we can leave only the text inside a jsevent method to be translated.

	```javascript
	// bad
	&Msg = "confirm('Are you sure you want to add an exception?')"
    &LstExc.JSEvent( "onclick", &Msg)

	// good
	&Msg = format( !"confirm('%1')", "Are you sure you want to add an exception?")
    &LstExc.JSEvent( "onclick", &Msg)

	```

  <a name="strings-trans"></a><a name="5.2"></a>
  - [5.2](#strings-trans) Use !"" for strings that must not be translated.
    > A translator could modify constants or system-specific codes and affect the behavior, for example parameters.

    ```javascript
    // bad
    &ParmVal = ParamGet( "GLOBAL ENCRYPT KEY")

    // good
    &ParmVal = ParamGet( !"GLOBAL ENCRYPT KEY")
    ```

  <a name="strings-quotation"></a><a name="5.3"></a>
  - [5.3](#strings-quotation) Use single quotes by default.
    > We do it this way because every event or subroutine created by GeneXus uses single quotes.

    ```javascript
    // bad
    &Msg = "Hello world!"

    // good
    &Msg = 'Hello world!'
    ```

**[Back to Top](#table-of-contents)**

## Comments

  <a name="comments--multiline"></a><a name="6.1"></a>
  - [6.1](#comments--multiline) Use `/** ... */` for multi-line comments in behavior descriptions. You can still use `//` since GeneXus allows auto-commenting with Ctrl-Q | Ctrl-Shift-Q.

    ```javascript
    // bad
    // CreateClient creates a new client
    // based on the variables:
    // &ClientName
    // &ClientAddress
    sub 'CreateClient'
      // ...
    endsub

    // good
    /**
     * CreateClient creates a new client
     * based on the variables:
     * &ClientName
     * &ClientAddress
     */
    sub 'CreateClient'
       // ...
    endsub
    ```

  <a name="comments--singleline"></a><a name="6.2"></a>
  - [6.2](#comments--singleline) Use `//` for single-line comments. These comments must be on the line before the subject being commented. Leave a blank line before the comment unless it is the first line of the block or you are commenting a where in a for-each.

    ```javascript
    // bad
    &ClientName = "John Doe" // Assign the name to the variable

    // good
    // Assign the name to the variable
    &ClientName = "John Doe"

    // bad
    sub 'CreateClient'
       msg( "Creating client", status)
       // Create the client
       &ClientBC = new()
       &ClientBC.ClientName = "John Doe"
       &ClientBC.Save()
    endsub

    // good
    sub 'CreateClient'
       msg( "Creating client", status)

       // Create the client
       &ClientBC = new()
       &ClientBC.ClientName = "John Doe"
       &ClientBC.Save()
    endsub

    // this is also good
    sub 'CreateClient'
       // Create the client
       &ClientBC = new()
       &ClientBC.ClientName = "John Doe"
       &ClientBC.Save()
    endsub
    ```

  <a name="comments--spaces"></a><a name="6.3"></a>
  - [6.3](#comments--spaces) Start every comment with a space so they are easy to read.

    ```javascript
    // bad
    //Is active
    &IsActive = true

    // good
    // Is active
    &IsActive = true

    // bad
    /**
     *Get the company name
     *to display it afterwards
     */
    &CompanyName = CompanyNameGet( &CompanyId)

    // good
    /**
     * Get the company name
     * to display it afterwards
     */
    &CompanyName = CompanyNameGet( &CompanyId)
    ```

  <a name="comments--actionitems"></a><a name="6.4"></a>
  - [6.4](#comments--actionitems) Prefixing comments with `FIXME` or `TODO` helps other developers quickly understand whether they are looking at a possible problem that needs to be reviewed or at a suggested solution to an existing problem. These are different from regular comments because they call for action. Those actions are `FIXME: -- needs to be solved` or `TODO: -- needs to be implemented`.

  <a name="comments--fixme"></a><a name="6.5"></a>
  - [6.5](#comments--fixme) Use `// FIXME:` to flag problems.

    ```javascript
    // FIXME: Check when &Divisor is 0
    &Total = &Dividend / &Divisor
    ```

  <a name="comments--todo"></a><a name="6.6"></a>
  - [6.6](#comments--todo) Use `// TODO:` to flag implementations to be done.

    ```javascript
    // TODO: Implement the subroutine
    sub "CreateClient"
    endsub
    ```

**[Back to Top](#table-of-contents)**

## Commands and Functions

  <a name="commands--naming"></a><a name="7.1"></a>
  - [7.1](#commands--naming) Use lowercase when naming system commands and functions.
	> This optimizes development since the commands and functions provided by the language are used so frequently that there is no need to write them in PascalCase.

    ```javascript
    // bad
    For Each
       Where ClientId = &ClientId
       Msg( ClientName)
    EndFor

    // good
    for each
       where ClientId = &ClientId

       msg( ClientName)
    endfor

    // bad
    &Date = YmdToD( 2017, 01, 01)

    // good
    &Date = ymdtod( 2017, 01, 01)
    ```

  <a name="commands--case"></a><a name="7.2"></a>
  - [7.2](#commands--case) Use [do case](http://wiki.genexus.com/commwiki/servlet/wiki?31605,Do%20Case%20command) whenever possible to replace nested [if](http://wiki.genexus.com/commwiki/servlet/wiki?8608,If+Command,) statements. Leave a space between each case block.

    ```javascript
    // bad
    if &DocumentType = DocumentTypes.Sale
       ...
    else
   	   if &DocumentType = DocumentTypes.Purchase
          ...
       endif
	endif

    // also bad
    do case
       case &DocumentType = DocumentTypes.Sale
          ...
       case &DocumentType = DocumentTypes.Purchase
          ...

	endcase

    // good
    do case
       case &DocumentType = DocumentTypes.Sale
          ...

       case &DocumentType = DocumentTypes.Purchase
          ...

       otherwise
          ...
	endcase

    // also good - When there are multiple cases and the action is a single line.
	> This makes it easier to read all the options without scrolling.
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
  - [7.3](#commands--foreach-where) Use the where clause in [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) commands instead of "if" statements, whenever dealing with [extended table](http://training.genexus.com/resumen-de-conceptos-fundamentales-de-genexus-es#tabla-base-y-tabla-extendida-resumen-de-conceptos-fundamentales) attributes.
	> This moves the condition to the DBMS and makes it part of the select query, avoiding working with large volumes of data in the application server or eventually in the client.

    ```javascript
    // bad
    for each Documents
       if DocumentType = DocumentTypes.Sales
          ...
       endif
    endfor

    // good
    for each
       where DocumentType = DocumentTypes.Sales
       ...
    endfor
    ```

  <a name="commands--foreach-when"></a><a name="7.4"></a>
  - [7.4](#commands--foreach-when) Use "when" in [for each](http://wiki.genexus.com/commwiki/servlet/wiki?24744,For%20Each%20command) commands to simplify the query sent to the DBMS.

    ```javascript
    // bad
    for each Documents
       where DocumentType = DocumentTypes.Sales
       where DocumentDate >= &StartDate or null(&StartDate)
       ...
    endfor

    // good
    for each
       where DocumentType = DocumentTypes.Sales
       where DocumentDate >= &StartDate when not &StartDate.IsEmpty()

       ...
    endfor
    ```

  <a name="commands--syntax"></a><a name="7.5"></a>
  - [7.5](#commands--syntax) Use the latest syntax whenever the version supports it.

    ```javascript
    // bad
    &Name = udp( PNameGet, &Id)

    // good
    &Name = PNameGet( &Id )

    // bad
    call( PNameSet, &Id, &Name)

    // good
    PNameSet( &Id, &Name)

    // bad
    &Num = val( &NumChar)

    // good
    &Num = &NumChar.ToNumeric()
    ```

**[Back to Top](#table-of-contents)**

## Parameters

  <a name="parms--sdt"></a><a name="8.1"></a>
  - [8.1](#parms--sdt) Use an SDT instead of multiple parameters.
	> This is important for objects with several in or out parameters, since reading becomes confusing and, if parameters need to change, all callers must be reviewed. If there are several output parameters, separate SDTs should be created, both for input and for output.

    ```javascript
	 // bad
	 parm( in:&ClientName, in:&ClientLastName, in:&ClientPhone, in:&ClientAddress, in:&ClientDOB);

	 // good
	 parm( in:&sdtClient);

	 // Web service example
	 // bad
	 parm( in:&Name, in:&Age, in:&MaritalStatus, out:&Id, out:&ErrorId);

	 // good
	 parm( in:&PersonCreateRequest, out:&PersonCreateResponse);
    ```

**[Back to Top](#table-of-contents)**

## Subroutines

  <a name="subs--title"></a><a name="9.1"></a>
  - [9.1](#subs--title) When defining subroutines, add the name as a comment on the same line.
  > This lets us see the subroutine name when they are collapsed.

  ```javascript
   // bad
   sub 'CreateClient'
      ...
   endsub

   Result: "+Sub Block"

   // good
   sub 'CreateClient' // Create Client
      ...
   endsub

   Result: "+Sub Block ('Create Client')"
  ```

**[Back to Top](#table-of-contents)**

## Good Practices

  <a name="bpractices--ver"></a><a name="10.1"></a>
  - [10.1](#bpractices--ver) Version the system as xx.yy.zz.

  Where:
	- xx: Major version changes of the system. It changes no more than once a year and generally implies a major change in the system.
	- yy: Incorporates database changes.
	- zz: Incorporates only changes in the binaries.

  <a name="bpractices--binver"></a><a name="10.2"></a>
  - [10.2](#bpractices--binver) Keep the current version of the application inside the binaries.
	> This makes it possible to know unambiguously which version of the application we are working with. The version can also be stored as a parameter inside the database, so we can get the difference with the version of the binaries and take the desired action.

	To achieve this, create a procedure that returns the version we are working with:

	```javascript
	// Parameters
	parm( out:&Version)

	// Source
	&Version = !"1.05.06"
	```

  <a name="bpractices--defpro"></a><a name="10.3"></a>
  - [10.3](#bpractices--defpro) Default properties

  Isolation level: Read committed  
  Generate prompt programs: No

  <a name="bpractices--pass"></a><a name="10.4"></a>
  - [10.4](#bpractices--pass) Do not show passwords in logs and debug information.
	> This improves the security of the systems, preventing credentials from being left in files and consoles with their potential security risks.

  <a name="bpractices--sdt"></a><a name="10.5"></a>
  - [10.5](#bpractices--sdt) Set specific namespaces in SDTs used in web services.
	> This avoids problems in production if the environment changes its default namespace. It is defined in the "name space" property of the SDT.

  <a name="bpractices--grids"></a><a name="10.6"></a>
  - [10.6](#bpractices--grids) Avoid loading grids by default.
	> In most cases the user will apply some filter, and loading by default wastes DBMS resources.

  <a name="bpractices--null"></a><a name="10.7"></a>
  - [10.7](#bpractices--null) Consider creating new attributes as "null".
	> It helps avoid re-creating the table on a Reorg. Especially on large tables where the data migration time can be too long.

  <a name="bpractices--session"></a><a name="10.8"></a>
  - [10.8](#bpractices--session) Avoid accessing sessions (websession) from procedures with business logic.
	> Session access should be the responsibility of the interface. Working with sessions inside procedures introduces interface logic into the problem domain. Because of this, we may later have problems if we want to use those procedures in batch or win console executions.

  <a name="bpractices--business"></a><a name="10.9"></a>
  - [10.9](#bpractices--business) Do not keep business logic in the interface.
	> Following the previous idea, business logic should not be incorporated into the interface.
  The clearest case on the web is generating Excel exports and reports in web panels. If instead we encapsulate them in procedures, we can eventually generate them from other interfaces.

**[Back to Top](#table-of-contents)**

## Resources

  - [GeneXus Wiki](http://wiki.genexus.com/) - GeneXus
  - [GeneXus Training](http://training.genexus.com) - GeneXus
  - [GeneXus Developpers](http://developers.genexus.com) - GeneXus
  - [GeneXus Marketplace](http://marketplace.genexus.com) - GeneXus
  - [GeneXus Search](http://search.genexus.com/) - GeneXus
  - [Stackoverflow](https://es.stackoverflow.com/questions/tagged/genexus)

## Companies that use this guide

  This is a list of organizations that are using this development guide. Let us know if your company uses this guide ([info@sincrum.com](mailto:info@sincrum.com)) or a fork of it and we will add you.

- [**Sincrum**](http://sincrum.com)
- [**Tangocode**](http://tangocode.com)
- [**GeneXus**](https://www.genexus.com)
- [**TributApp**](https://www.tributapp.com)
- [**I+Dev**](http://www.imasdev.com)
- [**Big Cheese**](https://bigcheese.com.uy)
- [**Neuronic**](https://neuronic.com.ar/)

**[Back to Top](#table-of-contents)**

## Translation

This style guide is also available in other languages:

  - ![es](https://raw.githubusercontent.com/gosquared/flags/master/flags/flags/shiny/24/Spain.png) [**Español**](README.md)

**[Back to Top](#table-of-contents)**

## Collaborators

  - [Laura Aguiar](https://uy.linkedin.com/in/laura-aguiar-396aa56)

## License

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)

The full text of the license is in the [LICENSE](LICENSE) file.

based on [AirBNB Javascript guide](http://airbnb.io/javascript/)

**[Back to Top](#table-of-contents)**

## Amendments

We encourage you to fork this guide and change the rules to fit your team's style guide. Below, you may list some amendments to the style guide. This allows you to periodically update your style guide without having to deal with merge conflicts.
