import { api, LightningElement } from 'lwc';

export default class ProjectMemberTiles extends LightningElement {
    @api listEmployee = [];
    selectedEmployeeId = '';

    handleEmployeeSelect(event) {
        this.selectedEmployeeId = event.detail.employeeId;
    }
}