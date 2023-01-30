/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
public with sharing class LeadTriggerHandler {
    List<Lead> newList;
    List<Lead> oldList;
    map<id,Lead> newMap;
    map<id,Lead> oldMap;
    
    public LeadTriggerHandler(List<Lead> newList, List<Lead> oldList, map<id,Lead> newMap, map<id,Lead> oldMap){
        this.newList = newList;
        this.oldList = oldList;
        this.newMap = newMap;
        this.oldMap = oldMap;
    }
    public void beforeInsert(){
        LeadHelper.checkCountry(newList);
    }
    public void beforeUpdate(){
        LeadHelper.checkCountry(newList);
    }

}