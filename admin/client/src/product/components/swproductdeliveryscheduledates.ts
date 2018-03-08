/// <reference path='../../../typings/slatwallTypescript.d.ts' />
/// <reference path='../../../typings/tsd.d.ts' />

class SWProductDeliveryScheduleDatesController {

    public productId:string;
    public componentId:string;
    
    public deliverScheduleDates;

    //@ngInject
    constructor(
        public $scope,
        public collectionConfigService
    ){
        
        this.getDeliveryScheduleDates();
        this.$scope.$watch('swProductDeliveryScheduleDates.deliverScheduleDates',(newValue,oldValue){
            if(newValue && newValue != oldValue){
                this.sortDeliveryScheduleDates();
            }
        })
    }
    
    public sortDeliveryScheduleDates=()=>{
        this.deliverScheduleDates.sort((a, b)=> {
            
            var a1 = Date.parse(a.deliveryScheduleDateValue).getTime();
            var b1 = Date.parse(b.deliveryScheduleDateValue).getTime();
            if (a1 > b1) return 1;
            if (a1 < b1) return -1;
            return 0;
            
        });
    }
    
    public getDeliveryScheduleDates=()=>{
        console.log(this.collectionConfigService);
        var deliveryScheduleDateCollection = this.collectionConfigService.newCollectionConfig('DeliveryScheduleDate');
        deliveryScheduleDateCollection.addFilter('product.productID',this.productId);
        deliveryScheduleDateCollection.setAllRecords(true);
        deliveryScheduleDateCollection.getEntity().then((data)=>{
            this.deliverScheduleDates = data.records;
        });
        
    }
    
    public addDate=(newDeliverScheduleDate)=>{
        if(newDeliverScheduleDate.deliveryScheduleDateValue){
            var deliverScheduleDate = angular.copy(newDeliverScheduleDate);
            deliverScheduleDate.deliveryScheduleDateValue = deliverScheduleDate.deliveryScheduleDateValue.toString().slice(0,24)
            this.deliverScheduleDates.push(deliverScheduleDate);
            this.sortDeliveryScheduleDates();    
        }
        
    }
}

class SWProductDeliveryScheduleDates implements ng.IDirective{

    public templateUrl; 
    public restrict = "EA";
    public scope = {};  
    
    public bindToController = {
        productId:"@"
    };
    
    public controller=SWProductDeliveryScheduleDatesController;
    public controllerAs="swProductDeliveryScheduleDates";
    
	public static Factory():ng.IDirectiveFactory{
        var directive:ng.IDirectiveFactory = (
		    productPartialsPath,
			slatwallPathBuilder
        ) => new SWProductDeliveryScheduleDates(
			productPartialsPath,
			slatwallPathBuilder
        );
        directive.$inject = [
			'productPartialsPath',
			'slatwallPathBuilder'
        ];
        return directive;
    }
    
    //@ngInject
	constructor(
	    private productPartialsPath,
		private slatwallPathBuilder
	){
		this.templateUrl = slatwallPathBuilder.buildPartialsPath(productPartialsPath) + "/productdeliveryscheduledates.html";
    }

    public link:ng.IDirectiveLinkFn = (scope: ng.IScope, element: ng.IAugmentedJQuery, attrs:ng.IAttributes) =>{
        scope.openCalendarStart = function($event) {
			$event.preventDefault();
			$event.stopPropagation();
		    scope.openedCalendarStart = true;
		};

		scope.openCalendarEnd = function($event) {
			$event.preventDefault();
			$event.stopPropagation();
		    scope.openedCalendarEnd = true;
		};
    }
}

export {
	SWProductDeliveryScheduleDatesController,
	SWProductDeliveryScheduleDates
};
