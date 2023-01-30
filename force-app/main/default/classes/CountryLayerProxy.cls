/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
public without sharing class CountryLayerProxy {
    public static Api_Setting__mdt api = [SELECT URL__c, Api_Key__c FROM Api_Setting__mdt WHERE DeveloperName = 'CountryLayer' LIMIT 1];
    
    public class RegionalBlocsWrapper{
        public String acronym {get;set;}
    }
    
    public class CountryLayerResponseWrapper{
        public String name {get;set;}
        public String alpha2Code {get;set;}
        public String alpha3Code {get;set;}
        public String capital {get;set;}
        public String region {get;set;}
        public String subregion {get;set;}
        public List<RegionalBlocsWrapper> regionalBlocs {get;set;}
    }

    @future(callout=true)
    public static void getCountries(){
        Map<String,Country__c> countryMapByCode = new Map<String,Country__c>();
        List<Country__c> countriesInsert = new List<Country__c>();
        // No need to put a limit on this call because the maximum countries are 195 (as google says) maybe one day this code needs a change lol
        for(Country__c c : [SELECT Id,Country_ISO_code_2__c, Name FROM Country__c]){
            countryMapByCode.put(c.Country_ISO_code_2__c,c);
        }
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(api.URL__c+'all?access_key='+api.Api_Key__c);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            List<CountryLayerResponseWrapper> clrwList = new List<CountryLayerResponseWrapper>();
            clrwList = (List<CountryLayerResponseWrapper>) System.JSON.deserialize(response.getBody(), List<CountryLayerResponseWrapper>.class);
            for(CountryLayerResponseWrapper clrw : clrwList){
                Country__c c = new Country__c(
                    Capital_City__c = clrw.capital,
                    Country_ISO_code_2__c = clrw.alpha2Code,
                    Country_ISO_code_3__c = clrw.alpha3Code,
                    Name = clrw.name,
                    Region__c = clrw.region,
                    Subregion__c = clrw.subregion
                );
                // I`m just getting here the first occurence because I`m not 100% sure how this should work if there is more
                if(clrw.regionalBlocs != null){
                    c.Regional_Blocs__c = clrw.regionalBlocs[0].acronym;
                }
                countriesInsert.add(c);
            }
            if(!countriesInsert.isEmpty()){
                UPSERT countriesInsert Country_ISO_code_2__c;
            }
        }
    }
}