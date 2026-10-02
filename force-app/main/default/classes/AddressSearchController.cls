public with sharing class AddressSearchController {

    @AuraEnabled
    public static Map<String, Object> searchAddress(
        String keyword,
        Integer currentPage,
        Integer countPerPage
    ){

        // 저장된 API 설정값
        JusoApiSetting__c objSetting = JusoApiSetting__c.getOrgDefaults();

        // API 승인키
        String confmKey = objSetting.ConfirmationKey__c;

        // UTF-8 인코딩
        String encodedKeyword =  EncodingUtil.urlEncode(keyword, 'UTF-8');

        // 기본 URL 설정
        String apiURL = 'https://business.juso.go.kr/addrlink/addrLinkApi.do'
                        + '?currentPage=' + currentPage
                        + '&countPerPage=' + countPerPage
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
        request.setTimeout(100000);
        request.setEndpoint(apiURL);

        HttpResponse response = http.send(request);

        return response.getBody();
    }


    @AuraEnabled
    public static void saveAddress(
        String recordId,
        String postalCode,
        String roadAddress,
        String detailAddress
    ){
        // Contact 주소 값 저장
        Contact objContact = new Contact(
            Id = RecordId,
            PostalCode__c = postalCode,
            RoadAddress__c = roadAddress,
            DetailAddress__c = detailAddress
        );

        update objContact;
    }
}