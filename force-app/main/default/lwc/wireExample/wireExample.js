import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class ReactiveExample extends LightningElement {
    @track searchTerm = ''; // 검색어 값
    accounts; // 결과 데이터
    error;
    
    // searchTerm 값이 변경되면 Apex 재호출
    @wire(getAccounts, { searchTerm: '$searchTerm' }) 
    wiredAccounts({ data, error }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }

    handleInputChange(event) {
        // input 필드 값이 변경될 때 searchTerm 업데이트
        this.searchTerm = event.target.value;
    }
}