public class ContactTriggerHandler {
	
    
    public static void insertContact(List<Contact> newList){
         List<Account> accList = new List<Account>();
         Map<Id,Contact>conIdMap = new Map<Id,Contact>();
        
        for(Contact con : newList){
            if(con.AccountId != null && con.Contact_Type__c == 'Customer'){
                conIdMap.put(con.AccountId, con);
            }
        }
        
          if(conIdMap.size() > 0 ){
            for(Account acc : [SELECT Id,Has_Customer__c FROM Account WHERE Id IN:conIdMap.KeySet()]){
                if(conIdMap.containsKey(acc.Id)){
                    acc.Has_Customer__c = true;
                    accList.add(acc);
                }
                
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
    
    public static void updateContact(List<Contact> newList, Map<Id, Contact> oldMap){
        
        List<Account> accList = new List<Account>();
        
        Map<Id,Contact>conIdMap = new Map<Id,Contact>();
        
        
        for(Contact con : newList){
          //  if(con.AccountId != null && con.Contact_Type__c != oldMap.get(con.Id).Contact_Type__c && con.Contact_Type__c == 'Customer'){
               if(con.AccountId != null && con.Contact_Type__c != oldMap.get(con.Id).Contact_Type__c){    
                conIdMap.put(con.AccountId, con);
            } 
        }
        
        if(conIdMap.size() > 0 ){
            for(Account acc : [SELECT Id,Has_Customer__c FROM Account WHERE Id IN:conIdMap.KeySet()]){
                if(conIdMap.containsKey(acc.Id) && conIdMap.get(acc.Id).Contact_Type__c == 'Customer'){
                    acc.Has_Customer__c = true;
                    accList.add(acc);
                }else if(conIdMap.containsKey(acc.Id) && conIdMap.get(acc.Id).Contact_Type__c == 'Not Customer'){
                    acc.Has_Customer__c = false;
                    accList.add(acc);
                }
                
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
}