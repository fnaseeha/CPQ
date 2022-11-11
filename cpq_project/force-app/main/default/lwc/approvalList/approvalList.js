import { LightningElement } from 'lwc';

export default class ApprovalList extends LightningElement {
    /*isLoading = false;
    @track data;
    @track haveData;
    connectedCallback() {
        this.getInitdata();
    }
    getInitdata(){

        this.isLoading = true;

        getShipment()
        .then(result => {
            console.log(result);
            this.data = result;
            //<a href="{!'data:' + v.file.ContentType+';base64,'+v.file.Content}">Download File</a>

          /*  let finalData = result;// JSON.parse(result);
            
           
            finalData.forEach(file => {
                console.log(file);
                file.ContentSize__c  = this.formatBytes(file.attach.ContentDocument.ContentSize, 2);
               
                let fileType = file.attach.FileType?.toLowerCase();
                //{!'data:' + data.ContentType+';base64,'+data.Content}
                file.attachment = 'data:'+file.ContentType+';base64,'+file.Content;
                if(imageExtensions.includes(fileType)){
                    file.icon = 'doctype:image';
                }else{
                    if(supportedIconExtensions.includes(fileType)){
                        file.icon = 'doctype:' + fileType;
                    }
                }
            });
            this.dataList = finalData;
            this.haveData = finalData?.length>0; 
            console.log(finalData);*/
            
     /*   })
        .catch(error => {
            console.error('**** error **** \n ',error)
        })
        .finally(()=>{
            this.isLoading = false;
        });
    }
    */

}