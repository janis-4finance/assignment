(function(){

	var class_name = 'Extension';
	
	Finance[ class_name ] = function()
	{
		Finance.Base.apply( this, arguments );
	}
	
	Finance.register( class_name );

	/*
	 * class properties
	 */
	Finance[ class_name ].prototype.properties =
	[
		'uuid',
		'loan_id',
		'days',
		'apr',
		'interest',
		'total',
	];
	
	/*
	 * loan()
	 */
	Finance[ class_name ].prototype.loan = function()
	{
		return Finance.Loan.find( this.loan_id );
	}
	
	/*
	 * get_total()
	 */
	Finance[ class_name ].prototype.get_total = function()
	{
		var self = this;
		return self.loan().total + self.loan().get_extension_cost( self.days );
	}
	
})();
