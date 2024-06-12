public class NewAccounts {
    public static void sObjectsInsert(){
        Account store = new Account();
        store.Name = 'The Tea Factory';
        store.AccountNumber = '356281';
        store.Phone = '555-0158';
        store.no_of_contacts__c=0;
        insert store;
    }
}