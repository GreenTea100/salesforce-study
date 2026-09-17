import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api studentName; // 부모로부터 "John Doe" 가 전달됨
}