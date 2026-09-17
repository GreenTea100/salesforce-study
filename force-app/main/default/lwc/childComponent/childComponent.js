// Child Component
import { LightningElement } from 'lwc';
export default class ChildComponent extends LightningElement {
    notifyParent() {
        const event = new CustomEvent('myevent', {
            detail: { message: 'Hello Parent!' }
        });
        this.dispatchEvent(event); //Event 보내기
    }
}