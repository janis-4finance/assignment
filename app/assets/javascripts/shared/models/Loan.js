(function(){

	var class_name = 'Loan';

	Finance.register( class_name );

	/*
	 * class properties
	 */
	Finance[ class_name ].prototype.properties =
	[
		'uuid',
		'user_id',
		'apr',
		'principal',
		'interest',
		'total',
		'approved',
		'disbursed',
		'repaid',
		'days',
		'maturity_date',
	];
	
	Finance[ class_name ].prototype.apr = 219; // default annual percentage rate is 219%
	
	/*
	 * user()
	 */
	Finance[ class_name ].prototype.user = function()
	{
		return Finance.User.find( this.user_id );
	}
	
	/*
	 * extensions()
	 */
	Finance[ class_name ].prototype.extensions = function()
	{
		var self = this;
		return Finance.Extension.all(function( candidate ){ return candidate.loan_id == self.uuid });
	}
	
	/*
	 * get_interest()
	 */
	Finance[ class_name ].prototype.get_interest = function()
	{
		var self = this;
		
		return self.principal * self.apr / 365 / 100 * self.days;
	}
	
	/*
	 * get_total()
	 */
	Finance[ class_name ].prototype.get_total = function()
	{
		var self = this;
		return self.principal + self.get_interest();
	}

})();
