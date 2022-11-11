import { LightningElement,api } from 'lwc';

import { NavigationMixin } from 'lightning/navigation';

export default class ProcessInvoiceD extends NavigationMixin(LightningElement) {
    @api recordId;

    handleNavigation() {
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId:  this.recordId,
            objectApiName: 'Quote',
            actionName: 'view'
        },

    });
 }
}