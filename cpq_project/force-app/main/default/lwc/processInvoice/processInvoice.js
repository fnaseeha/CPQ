import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ProcessInvoice extends NavigationMixin(LightningElement) {

    @api recordId;

   
    navigateToRecordViewPage() {
        console.log('recordId:', this.recordId);
        // View a custom object record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                actionName: 'view'
            }
        });
    }
}