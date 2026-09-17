Account acc = new Account();
acc.Name = 'Trigger Test Account';

insert acc;

Account result = [
    select id, name, rating
    from Account
    where id = :acc.id
];

system.debug('result = ' + result);