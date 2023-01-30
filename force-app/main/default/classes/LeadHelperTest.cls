/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
@isTest
public with sharing class LeadHelperTest {
    @TestSetup
    static void setup(){
        INSERT new Country__c(
            Name = 'Test'
        );
    }

    @isTest
    public static void testCheckCountryInsert(){
        Test.startTest();
        INSERT new Lead(
            FirstName = 'Test',
            LastName = 'Test',
            Company = 'Abc',
            Country = 'Test'
        );
        Test.stopTest();
        system.Assert([SELECT Id, Country__c FROM Lead LIMIT 1].Country__c != null);
    }
    
    @isTest
    public static void testCheckCountryUpdate(){
        Lead l = new Lead(
            FirstName = 'Test',
            LastName = 'Test',
            Company = 'Abc',
            Country = 'Test'
        );
        INSERT l;
        l.Country = '';
        Test.startTest();
        UPDATE l;
        Test.stopTest();
        system.Assert(l.Country__c == null);
    }
}