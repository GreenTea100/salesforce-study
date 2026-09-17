trigger ProjectMember on ProjectMember__c (before insert) {
    new ProjectMember_tr().run();
}