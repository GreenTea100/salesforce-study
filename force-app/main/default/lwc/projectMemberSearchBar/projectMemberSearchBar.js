import {LightningElement, wire} from 'lwc';
import getIndustryType from '@salesforce/apex/ProjectMemberSearchBar.getIndustryType';
import getProjectList from '@salesforce/apex/ProjectMemberSearchBar.getProjectList';

export default class ProjectMemberSearchBar extends LightningElement {

    //lightning-combobox에서 선택된 값
    selectedIndustryType = '';
    selectedProjectId = '';

    //lightning-combobox option값
    listIndustryTypes = [];
    listProjects = [];

    @wire(getIndustryType, )
    wired_getIndustryType({ error, data }) {
        console.log('wired_getIndustryType :: ' + JSON.stringify(data));
        this.listIndustryTypes = [];
        if (data && data.length) {
            this.listIndustryTypes = data.map(industryType => ({
                value: industryType,
                label: industryType
            }));
            this.listIndustryTypes.unshift({
                value: '',
                label: '선택'
            });
        } else if (error) {
            this.error = error;
        }
    }


    //$표시는 변화를 감지한다는 의미 : selectedIndustryType 값이 변하면 자동으로 Apex 실행
    @wire(getProjectList, {strIndustryType : '$selectedIndustryType'}) wired_getProjects({ error, data }) {
        console.log('wired_getProjects :: ' + JSON.stringify(data));
        this.listProjects = [];
        if(data){
            this.listProjects.push({
                value: '',
                label: '선택'
            });
            data.forEach(project => {
                this.listProjects.push({
                    value: project.Id,
                    label: project.Name
                });
            });
        }
        else if (error) {
            this.error = error;
        } 
    }

    onIndustryChange(event) {
        this.selectedProjectId = '';
        this.selectedIndustryType = event.target.value;
    }

    onProjectChange(event) {
        this.selectedProjectId = event.target.value;
        this.notifyParent();
    }

    notifyParent() {
        console.log('notifyParent called => Project Member Browser onfilterchange');
        
        // 프로젝트 Id 전달하는 이벤트 생성
        const evt = new CustomEvent('filterchange', {
            detail: {
                projectId: this.selectedProjectId
            }
        });

        // 부모 컴포넌트로 이벤트 전달함
        this.dispatchEvent(evt);
    }

}