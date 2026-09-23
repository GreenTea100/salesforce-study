// Custom Setting 승인키 해시 확인함
JusoApiSetting__c objSetting = JusoApiSetting__c.getOrgDefaults();
String confmKey = objSetting.ConfirmationKey__c;

String keyHash = EncodingUtil.convertToHex(
    Crypto.generateDigest(
        'SHA-256',
        Blob.valueOf(confmKey)
    )
);

System.debug('KEY_HASH = ' + keyHash);