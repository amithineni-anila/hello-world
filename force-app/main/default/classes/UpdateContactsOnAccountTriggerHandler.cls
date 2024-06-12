public class UpdateContactsOnAccountTriggerHandler {
    
  public static void afterUpdate(
    List<contact> triggerNew,
    List<contact> triggerOld
  ) {
    Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
	for(Contact newContact: TriggerNew) {
		Contact oldContact = new Contact();
        oldContact = (contact)Trigger.oldMap.get(newContact.Id);
		if(oldContact.accountId != newContact.accountId) {
			Integer newContactCount = contactCountMap.get(newContact.accountId);
		    if(newContactCount == null) {
				contactCountMap.put(newContact.accountId, 1);
			} else {
                contactCountMap.put(newContact.accountId, newContactCount + 1);
			}
            Integer oldContactCount = contactCountMap.get(oldContact.accountId);
			if(oldContactCount == null) {
				contactCountMap.put(oldContact.accountId, -1);
			} else {
				contactCountMap.put(oldContact.accountId, oldContactCount - 1);
			}			
		}
	}
    List<contact> contactListUpdate = new List<contact>();
    contactListUpdate.addAll(triggerNew);
    contactListUpdate.addAll(triggerOld);	
	List<account> accountList = relatedAccountsOfContacts(contactListUpdate);
	for(Account act: accountList) {
        if( act.No_of_related_contacts__c == null){
             act.No_of_related_contacts__c = 0;
        }
        act.No_of_related_contacts__c = act.No_of_related_contacts__c + contactCountMap.get(act.Id); 
	}
	update accountList;
  }

  public static void afterInsert(List<contact> triggerNew) {
    Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
    for (Contact con : triggerNew) {
      Integer contactCount = contactCountMap.get(con.accountId);
      if (contactCount == null) {
        contactCountMap.put(con.accountId, 1);
      } else {
        contactCountMap.put(con.accountId, contactCount + 1);
      }
    }
     List<account> accountList = relatedAccountsOfContacts(
      triggerNew
    );
    for (Account act : accountList) {
        if( act.No_of_related_contacts__c == null){
             act.No_of_related_contacts__c = 0;
        }
        act.No_of_related_contacts__c = act.No_of_related_contacts__c + contactCountMap.get(act.Id); 
    }
    update accountList;
  }

  public static void afterUndelete(List<contact> triggerNew) {
    Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
    for (Contact con : triggerNew) {
      Integer contactCount = contactCountMap.get(con.accountId);
      if (contactCount == null) {
        contactCountMap.put(con.accountId, 1);
      } else {
        contactCountMap.put(con.accountId, contactCount + 1);
      }
    }
    List<account> accountList = relatedAccountsOfContacts(
      triggerNew
    );
    for (Account act : accountList) {
        act.No_of_related_contacts__c = act.No_of_related_contacts__c + contactCountMap.get(act.Id); 
    }
    update accountList;
  }

  public static void afterDelete(List<contact> triggerOld) {
   Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
      System.debug(contactCountMap);
    for (Contact con : triggerOld) {
      Integer contactCount = contactCountMap.get(con.accountId);
        System.debug(contactCount);
      if (contactCount == null) {
        contactCountMap.put(con.accountId, -1);
      } else {
        contactCountMap.put(con.accountId, contactCount - 1);
      }
    }
    List<account> accountList = relatedAccountsOfContacts(
      triggerOld
    );
    for (Account act : accountList) {
        act.No_of_related_contacts__c = act.No_of_related_contacts__c + contactCountMap.get(act.Id);
    }
    update accountList;
  }

  private static List<account> relatedAccountsOfContacts(
    List<contact> contactList
  ) {
    Set<id> accountIdsSet = new Set<id>();
    for (Contact con : contactList) {
      accountIdsSet.add(con.accountId);
    }
    List<Account> accountList = [
      SELECT Id, Name, No_Of_related_Contacts__c, (SELECT Name FROM Contacts)
      FROM Account
      WHERE Id IN :accountIdsSet
    ];
    return accountList;
  }
}