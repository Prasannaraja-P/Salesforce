/* SOSL
Salesforce Object Search Language (SOSL)
Used to perform text search in records.
Use SOSL to search fields across multiple sObjects records.
Use SOQL to retrieve records for a single object whereas use SOSL
to search fields across multiple objects.

FIND {SearchQuery} 
[ IN SearchGroup ]
[ RETURNING FieldSpec [[ toLabel(fields)] [convertCurrency(Amount)] [FORMAT()]] ]
[ WITH DivisionFilter ]
[ WITH DATA CATEGORY DataCategorySpec ]
[ WITH SNIPPET[(target_length=n)] ]
[ WITH NETWORK NetworkIdSpec ]
[ WITH PricebookId ]
[ WITH METADATA ]
[ LIMIT n ]

[ UPDATE [TRACKING], [VIEWSTAT] ]
*/

//--------------------------------------------------- EXAMPLES ---------------------------------------------------
Find {Test}

//************ Where ? ************
Find {Test} RETURNING Account,Contact

//************ What Type ************
Find {Test} IN Name Fields 
Find {Test} IN Email Fields 

// ************ RETURN WHICH FIELDS ? ************
Find {Test} IN Name Fields RETURNING Account(Name)

Find {Test} IN Name Fields RETURNING Account(Name),Contact(FirstName)

************ WildCards in SOQL ************
//01 *(Asterisk)
Find {Test*} IN Name Fields RETURNING Account(Name),Contact(FirstName)

//02 ?(Question Mark)
Find {T?st} IN Name Fields RETURNING Account(Id,Name,AnnualRevenue ORDER BY Name),Contact(FirstName)

//************ WHERE ************
//WHERE clause, you must include a field list with at least one specific field.

Find {Test*} IN Name Fields RETURNING Account(Name,Phone Where Rating='Hot')

//************ ORDER BY ************
Find {Test*} IN Name Fields RETURNING Account(Name,Phone Where Rating='Hot' ORDER BY Name DESC)
Find {Test OR AJSD} IN Name Fields RETURNING Account(Id,Name,AnnualRevenue ORDER BY Name),Contact(FirstName)

/************ SEARCH GROUP ************
Search in specified fields 
1) All Fields (By Default)
2) Name Fields
3) Email Fields
4) Phone Fields
5) Sidebar Fields
*/

//************ All FIELDS ************
List<List<SObject>> soList=[Find 'Test' IN ALL FIELDS 
                            RETURNING Account,COntact ];
List<Account> aList=soList[0];
List<Contact> cList=soList[1];
for(Account a: aList){
    System.debug(a);
}
system.debug('-------------------------------');
for(Contact c: cList){
    System.debug(c);
}

//************ Name FIELDS ************
List<List<SObject>> soList=[Find 'Test' IN Name FIELDS 
                            RETURNING Account(Name,BillingCountry),Contact(FirstName)];
List<Account> accounts=soList[0];
System.debug(accounts[0].Name);

//************ Email FIELDS ************
List<List<sObject>> sList= [FIND '*com' IN EMAIL FIELDS RETURNING Contact(FirstName,LastName,
                                                                          Email)];
List<Contact> con = sList[0];
System.debug(con[0]. Email); 

//************ Phone FIELDS ************
List<List<sObject>> sList= [FIND '(1234567890)' IN PHONE FIELDS RETURNING Contact(FirstName,LastName,
                                                                                  Phone)];
System.debug(sList); 

//************ Sidebar FIELDS ************
List<List<sObject>> sList= [FIND '1234567890' IN SIDEBAR FIELDS RETURNING Contact(FirstName, LastName, Phone)];
System.debug(sList); 

//************ DYNAMIC SOSL ************
String s = 'Find \'Test\' RETURNING Account,Contact' ;
List<List<sObject>> sList = Search.query(s);
system.debug(sList);

//************ IN METHOD 1 ************
public static void soslExample(){
        List<List<Sobject>> soslResults=[Find 'Test' IN ALL FIELDS 
                                         RETURNING Account(Id,Name),COntact(Id ,Name)];
        System.debug('Result :::'+soslResults);
        for(List<SObject> objList:soslResults){
            for(SObject obj:objList){
                System.debug('This is our Object ::: '+obj);
            }
        }
    }

//************ IN METHOD 2 ************
  public static void soslExample3(){
         List<List<Sobject>> soslResults=[Find 'Test' IN ALL FIELDS 
                                          RETURNING Account(Id,Name),Contact(Id ,Name)];
         //System.debug('Result :::'+soslResults);
         
         List<Account> accList=(List<Account>) soslResults[0];
         List<Contact> conList=(List<Contact>) soslResults[1];
         
         for(Account  obj:accList){
             System.debug('Account Name ::: '+obj.Name);
         }
         
         for(Contact  obj:conList){
             System.debug('Contact Name ::: '+obj.Name);
         }
     }
