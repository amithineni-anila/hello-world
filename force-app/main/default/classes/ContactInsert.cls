public class ContactInsert {
    Public static void conInsert(){
        Contact newCon= new Contact();
        newCon.FirstName='raj';
        List<Account> acc = [SELECT id,Name from Account WHERE Name='The Tea Factory'];
       newCon.AccountId=acc[0].Id;
       //System.debug(acc);
        newCon.LastName='at';
        insert newCon;
    }

}