@isTest
public class ContactTriggerHandlerTest {

    @testSetup
    public static void testData(){
        
        Account acc = new Account();
        acc.Name = 'Test1';
        acc.Has_Customer__c = false;
        
        insert acc;
        
        Contact con1 = new Contact();
        con1.AccountId = acc.Id;
        con1.LastName = 'TestCon1';
        con1.Contact_Type__c = 'Customer';
      
        
        insert con1;
        system.debug('con--'+con1);
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'TestCon2';
        con.Contact_Type__c = 'Not Customer';
      
        
        insert con;
        system.debug('con--'+con);
         
        
    }
    
    @isTest
    public static void test1(){
         List<Account> accs = [SELECT Id,Has_Customer__c FROM Account LIMIT 1];
        
        List<Contact> cons = [SELECT Id,AccountId, Contact_Type__c FROM Contact WHERE AccountId =:accs[0].Id];
        cons[0].Contact_Type__c = 'Customer';
        
        update cons;
        
        List<Account> accList = [SELECT Id,Name,Has_Customer__c FROM Account
                                 LIMIT 1];
      
        system.assertEquals(true, accList[0].Has_Customer__c);
        
    }
    
     @isTest
    public static void test2(){
         List<Account> accs = [SELECT Id,Has_Customer__c FROM Account LIMIT 1];
        
        List<Contact> cons = [SELECT Id,AccountId, Contact_Type__c FROM Contact WHERE
                              AccountId =:accs[0].Id AND LastName = 'TestCon2'];
        cons[0].Contact_Type__c = 'Customer';
        
        update cons;
        
        List<Account> accList = [SELECT Id,Name,Has_Customer__c FROM Account
                                 LIMIT 1];
      
        system.assertEquals(true, accList[0].Has_Customer__c);
        
    }

    
    
}