import { api, LightningElement } from 'lwc';

export default class ProjectMemberTile extends LightningElement {
    @api employee;
    @api selectedEmployeeId = '';
    @api isSelected = false;

    get tileSelected() {
        return (this.selectedEmployeeId === this.employee.Id) ? "tile selected" : "tile";
    }

    employeeClick() {
        const evt = new CustomEvent('employeeselect', {
            detail: { employeeId: this.employee.Id }
        });
        this.dispatchEvent(evt);
    }

}