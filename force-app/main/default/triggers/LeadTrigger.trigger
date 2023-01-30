/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
trigger LeadTrigger on Lead(before insert, before update) {
    LeadTriggerHandler handler = new LeadTriggerHandler(Trigger.new,Trigger.old,Trigger.newMap, Trigger.oldMap);
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            handler.beforeInsert();
        }else if(Trigger.isUpdate){
            handler.beforeUpdate();
        }
    }
}