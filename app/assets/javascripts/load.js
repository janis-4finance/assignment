jQuery(function()
{
	// load models
	jQuery.ajax
	({
		url: '/loans.json',
		dataType: 'json',
		success: function( json )
		{
			var instances = Finance.db.load( json );
			instances.foreach(function( instance )
			{
				instance.trigger( 'mutate' );
			});
		}
	});
});
