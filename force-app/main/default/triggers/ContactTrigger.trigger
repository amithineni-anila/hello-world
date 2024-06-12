trigger ContactTrigger on Contact(
  after insert,
  after update,
  after undelete,
  after delete
) {
  if (Trigger.isInsert) {
    contactTriggerHandler.afterInsert(Trigger.New);
  }
  if (Trigger.isUndelete) {
    contactTriggerHandler.afterUndelete(Trigger.New);
  }
  if (Trigger.IsDelete) {
    contactTriggerHandler.afterDelete(Trigger.Old);
  }
  if (Trigger.IsUpdate) {
     contactTriggerHandler.afterUpdate(Trigger.New,Trigger.Old);
  }
}