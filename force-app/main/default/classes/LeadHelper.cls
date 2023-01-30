/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
public with sharing class LeadHelper {
    public static void checkCountry(List<Lead> newList){
        Map<String, Id> countryNameId = new Map<String, Id>();
        for(Country__c c : [SELECT Id,Name FROM Country__c]){
            countryNameId.put(c.Name, c.Id);
        }
        for(Lead l : newList){
            if(l.Country != null && countryNameId.containsKey(l.Country)){
                l.Country__c = countryNameId.get(l.Country);
            }else{
                l.Country__c = null;
            }
        }
    }
}