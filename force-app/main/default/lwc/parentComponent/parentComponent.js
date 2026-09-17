// Parent Component
import { LightningElement } from 'lwc';
export default class ParentComponent extends LightningElement {
    handleMyEvent(event) {
        console.log('Message from child:', event.detail.message);
    }
}