import { LightningElement, wire } from 'lwc';
import getEmployee from '@salesforce/apex/ProjectMemberBrowser.getEmployee'

export default class ProjectMemberBrowser extends LightningElement {

    selectedProjectId = '';
    //$표시는 변화를 감지한다는 의미 : selectedProjectId값이 변하면 자동으로 Apex 실행
    @wire(getEmployee, { projectId: '$selectedProjectId' }) employees;

    handleFilterChange(event) {
        console.log('handleFilterChange called');
        this.selectedProjectId = event.detail.projectId;
    }
}