/**
 * @description       : 
 * @author            : rodrigo.carpanedo@
 * @group             : 
 * @last modified on  : 01-30-2023
 * @last modified by  : rodrigo.carpanedo
**/
@isTest
public with sharing class CountryLayerProxyTest {
    public class YourHttpCalloutMockImpl implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"name": "Afghanistan","topLevelDomain": [".af"],"alpha2Code": "AF","alpha3Code": "AFG","callingCodes": ["93"],"capital": "Kabul","altSpellings": ["AF","Afġānistān"],"region": "Asia","subregion": "Southern Asia","population": 27657145,"latlng": [33,65],"demonym": "Afghan","area": 652230,"gini": 27.8,"timezones": ["UTC+04:30"],"borders": ["IRN","PAK","TKM","UZB","TJK","CHN"],"nativeName": "افغانستان","numericCode": "004","currencies": [{"code": "AFN","name": "Afghan afghani","symbol": "؋"}],"languages": [{"iso639_1": "ps","iso639_2": "pus","name": "Pashto","nativeName": "پښتو"},{"iso639_1": "uz","iso639_2": "uzb","name": "Uzbek","nativeName": "Oʻzbek"},{"iso639_1": "tk","iso639_2": "tuk","name": "Turkmen","nativeName": "Türkmen"}],"translations": {"br": "Afeganistão","de": "Afghanistan","es": "Afganistán","fa": "افغانستان","fr": "Afghanistan","hr": "Afganistan","it": "Afghanistan","ja": "アフガニスタン","nl": "Afghanistan","pt": "Afeganistão"},"flag": "https://restcountries.eu/data/afg.svg","regionalBlocs": [{"acronym": "SAARC","name": "South Asian Association for Regional Cooperation"}],"cioc": "AFG"}]');
            res.setStatusCode(200);
            return res;

        }
    }
    
    @TestSetup
    static void setup(){
        
    }
    
    @isTest
    static void testSchedule(){
        Test.setMock(HttpCalloutMock.class, new YourHttpCalloutMockImpl());
        CheckCountriesSchedule m = new CheckCountriesSchedule();
        String sch = '20 30 8 10 2 ?';
        System.schedule('Merge Job', sch, m);
    }

    @isTest
    static void testGetCountries(){
        Test.setMock(HttpCalloutMock.class, new YourHttpCalloutMockImpl());
        Test.startTest();
        CountryLayerProxy.getCountries();
        Test.stopTest();
        System.assertEquals(1, [SELECT Id FROM Country__c LIMIT 1].size());
        
    }
    
    @isTest
    static void testGetCountriesUpdate(){
        Test.setMock(HttpCalloutMock.class, new YourHttpCalloutMockImpl());
        Country__c c = new Country__c(
        	Country_ISO_code_2__c = 'AF'
        );
        insert c;
        Test.startTest();
        CountryLayerProxy.getCountries();
        Test.stopTest();
        System.assertEquals(1, [SELECT Id FROM Country__c].size());
        
    }
}