public class contactTriggerHandler {
  public static void afterUpdate(
    List<contact> triggerNew,
    List<contact> triggerOld
  ) {
    List<contact> contactListUpdate = new List<contact>();
    contactListUpdate.addAll(triggerNew);
    contactListUpdate.addAll(triggerOld);
    updateAccountWithNumberOfContacts(contactListUpdate);
  }

  public static void afterInsert(List<contact> triggerNew) {
    updateAccountWithNumberOfContacts(triggerNew);
  }

  public static void afterUndelete(List<contact> triggerNew) {
    updateAccountWithNumberOfContacts(triggerNew);
  }

  public static void afterDelete(List<contact> triggerOld) {
    updateAccountWithNumberOfContacts(triggerOld);
  }

  private static void updateAccountWithNumberOfContacts(
    List<contact> contactList
  ) {
    Set<id> accountIdsSet = new Set<id>();

    for (Contact con : contactList) {
      accountIdsSet.add(con.accountId);
    }

    List<Account> accountList = [
      SELECT Name, No_Of_Contacts__c, (SELECT Name FROM Contacts)
      FROM Account
      WHERE Id IN :accountIdsSet
    ];

    for (Account acc : accountList) {
      acc.No_of_contacts__c = acc.contacts.size();
    }

    update accountList;
  }
}