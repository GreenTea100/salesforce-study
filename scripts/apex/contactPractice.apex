List<Contact> contactList = [
    SELECT Id, FirstName, LastName, Birthdate
    FROM Contact
    LIMIT 3
];

System.debug('contactList = ' + contactList);







Map<Id, Date> contactBirthdateMap = new Map<Id, Date>();

for (Contact con : contactList) {
    contactBirthdateMap.put(con.Id, con.Birthdate);
}

System.debug('contactBirthdateMap = ' + contactBirthdateMap);







Id firstContactId = contactList[0].Id;

Date firstBirthdate =
    contactBirthdateMap.get(firstContactId);

System.debug('firstContactId = ' + firstContactId);
System.debug('firstBirthdate = ' + firstBirthdate);

for(Contact con : contactList){
    con.Birthdate = Date.today();
}

if(!contactList.isEmpty()) {
    update contactList;
}

System.debug('Updateed contactList = ' + contactList);




Set<Id> contactIdSet = new Set<Id>();

for(Contact con : contactList){
    contactIdSet.add(con.Id);
}

List<Contact> updatedContactList = [
    Select Id, FirstName, LastName, Birthdate
    From Contact
    Where Id In :contactIdSet
];

System.debug('updatedContactList = ' + updatedContactList);