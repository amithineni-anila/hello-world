@isTest
public class UpdateContactsOnAccountTest {
    @testSetUp static void dataSetUp(){
        Account acc1 = new Account();
        acc1.Name = 'Ajay_IceCreams';
        insert acc1;
        Account acc2 = new Account();
        acc2.Name = 'Sai_IceCreams';
        insert acc2;
    }
    
    @isTest public static void afterInsertTest(){
        Account acc = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Ajay_IceCreams' LIMIT 1];
       List<Contact> conList = new List<Contact>();
        Contact con1 = new Contact();
        con1.LastName = 'Kiran';
        con1.Accountid = acc.Id;
        conList.add(con1);
        UpdateContactsOnAccountTriggerHandler.afterInsert(conList); 
        Account acc1 = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Ajay_IceCreams' LIMIT 1];
        Assert.areEqual(1,acc1.No_of_related_contacts__c);
    }
    
    @isTest public static void afterDeleteTest(){
        Account acc = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Ajay_IceCreams' LIMIT 1];
        List<Contact> conList = new List<Contact>();
        Contact con1 = new Contact();
        con1.LastName = 'sasi';
        con1.Accountid = acc.Id;
        conList.add(con1);
        UpdateContactsOnAccountTriggerHandler.afterInsert(conList);
        System.debug(conList);
        List<contact> contact1 = [ Select Lastname, Accountid from contact where Lastname = 'sasi' LIMIT 1];
        System.debug(contact1);
        delete contact1;
        System.debug(contact1);
        UpdateContactsOnAccountTriggerHandler.afterDelete(contact1);
        
         Account acc1 = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Ajay_IceCreams' LIMIT 1];
        Assert.areEqual(null,acc1.No_of_related_contacts__c);
    }
    
    @isTest public static void afterUpdateTest(){
        Account acc1 = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Ajay_IceCreams' LIMIT 1];
        List<Contact> oldList = new List<Contact>();
        List<Contact> updateContact = new List<Contact>();
        Contact con1 = new Contact();
        con1.LastName = 'Vamsi';
        con1.Accountid = acc1.Id;
        insert con1;
        updateContact.add(con1);
        UpdateContactsOnAccountTriggerHandler.afterInsert(updateContact); 
        contact oldContact =  [ Select Lastname, Accountid from contact where Lastname = 'Vamsi' LIMIT 1];
        oldList.add(oldContact);
        Account acc2 = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Sai_IceCreams' LIMIT 1];
        oldContact.Accountid = acc2.Id;
        List<contact> newList =  [ Select Lastname, Accountid from contact where Lastname = 'Vamsi' LIMIT 1];
        UpdateContactsOnAccountTriggerHandler.afterUpdate(newList,oldList);
        Account oldAccount = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Ajay_IceCreams' LIMIT 1];
        Assert.areEqual(null,oldAccount.No_of_related_contacts__c);
        Account newAccount = [Select id, No_of_related_contacts__c from Account WHERE Name = 'Sai_IceCreams' LIMIT 1];
        Assert.areEqual(1,newAccount.No_of_related_contacts__c);
       
    }
        
}