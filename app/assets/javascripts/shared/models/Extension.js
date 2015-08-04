(function(){

	var class_name = 'Extension';

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
	
})();
