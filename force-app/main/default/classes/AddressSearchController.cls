public with sharing class AddressSearchController {
    
    @AuraEnabled
    public static Map<String, Object> searchAddress(String keyword){

        // 저장된 API 설정값
        JusoApiSetting__c objSetting = JusoApiSetting__c.getOrgDefaults();

        // API 승인키
        String confmKey = objSetting.ConfirmationKey__c;

        // UTF-8 인코딩 
        String encodedKeyword =  EncodingUtil.urlEncode(keyword, 'UTF-8');

        // 기본 URL 설정
        String apiURL = 'https://business.juso.go.kr/addrlink/addrLinkApi.do'
                        + '?currentPage=1'
                        + '&countPerPage=10'
                        + '&keyword=' + encodedKeyword
                        + '&confmKey=' + EncodingUtil.urlEncode(confmKey, 'UTF-8')
                        + '&resultType=json';

        // 주소 API 호출
        String responseBody = webCallOut(apiURL);

        // JSON 변환
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);

        return responseMap;
    }


    private static String webCallOut(String apiURL){
        // API 호출
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setMethod('GET');
        request.setTimeout(110000);
        request.setEndpoint(apiURL);

        HttpResponse response = http.send(request);

        return response.getBody();
    }
}