trigger contactTrigger on Contact (after insert, after update) {

  if(Trigger.isAfter && Trigger.isInsert){
        
        ContactTriggerHandler.insertContact(Trigger.New);
    }else
        if(Trigger.isAfter && Trigger.isUpdate){
        ContactTriggerHandler.updateContact(Trigger.New, Trigger.oldMap);
    }
    

    
    
}