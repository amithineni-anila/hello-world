trigger UpdateNumberOfContactsOnAccountTrigger on Contact (
  after insert,
  after update,
  after undelete,
  after delete
) {
  if (Trigger.isInsert) {
    UpdateContactsOnAccountTriggerHandler.afterInsert(Trigger.New);
  }
    
  if (Trigger.isUndelete) {
    UpdateContactsOnAccountTriggerHandler.afterUndelete(Trigger.New);
  }
 
  if (Trigger.IsDelete) {
    UpdateContactsOnAccountTriggerHandler.afterDelete(Trigger.Old);
  }
    
  if (Trigger.IsUpdate) {
     UpdateContactsOnAccountTriggerHandler.afterUpdate(Trigger.New,Trigger.Old);
  }
}