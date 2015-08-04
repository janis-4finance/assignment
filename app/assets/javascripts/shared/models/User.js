(function(){

	var class_name = 'User';

	Finance.register( class_name );

	/*
	 * class properties
	 */
	Finance[ class_name ].prototype.properties =
	[
		'uuid',
		'name',
		'phone',
		'iban',
		'created_at'
	];

})();
