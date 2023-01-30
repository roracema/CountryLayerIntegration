/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
global class CheckCountriesSchedule Implements Schedulable{
    global void execute(SchedulableContext sc){
        CountryLayerProxy.getCountries();
    }
}