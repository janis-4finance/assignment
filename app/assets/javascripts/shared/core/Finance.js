(function( this_or_window ){
	
	var is_nodejs = false;
	if( typeof exports != 'undefined' )
	{
		is_nodejs = true;
	}
	
	var Finance = {};
	if( is_nodejs )
	{
		Finance = this_or_window;
	}
	else
	{
		this_or_window.Finance = Finance;
	}
	
	/**
	 * known classes
	 */
	Finance.classes = {};
	
	/**
	 * registration handlers
	 */
	Finance.registration_handlers = {};
	
	Finance.on_register = function( class_name, callback )
	{
		if( Finance[ class_name ] )
		{
			callback();
		}
		else
		{
			if( !Finance.registration_handlers[ class_name ] )
			{
				Finance.registration_handlers[ class_name ] = [];
			}
			Finance.registration_handlers[ class_name ].push( callback );
		}
	};
	
	/**
	 * registers new class and attaches event functionality
	 */
	Finance.register = function( class_name, after, parent )
	{
		Finance[ class_name ] = Finance[ class_name ] || function(){};
		
		parent = parent || Finance.Base;
		
		Finance[ class_name ].prototype = new parent();
		Finance.classes[ class_name ] = true;
		
		// copy base classes' class-wide methods
		for( var i in parent )
		{
			if( typeof parent[i] == 'function' )
			{
				Finance[ class_name ][i] = parent[i];
			}
		}
		
		// store class name
		//Finance[ class_name ].class_name = class_name;
		Finance[ class_name ].prototype.class_name = class_name;
		
		// execute registration callbacks
		if( Finance.registration_handlers[ class_name ] )
		{
			setTimeout(function() // this is required for class definition to fully execute
			{
				Finance.registration_handlers[ class_name ].foreach(function( item )
				{
					item();
				});
			}, 0);
		}
	};
	
	/**
	 * controller namespaces
	 */
	Finance.controllers = {};
	
})( this );

// fix less-than-ideal decision by standards committee :)
Array.prototype.foreach = Array.prototype.forEach;


