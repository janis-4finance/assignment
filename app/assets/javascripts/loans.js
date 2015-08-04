//= require jquery-ui/datepicker

jQuery(function()
{
	var controller = jQuery( '.controller-loans' );
	
	var options =
	{
		firstDay:    1, // start week with monday
		minDate:     0,  // no dates in past
		maxDate:     30,  // up to 30 days
		defaultDate: 30
	};
	var datepicker = controller.find( '.calendar' ).datepicker( options );
	
	datepicker.datepicker( 'option', 'onSelect', function()
	{
		console.log( arguments );
	});
	
	datepicker.datepicker( 'option', 'gotoCurrent', true );
	
});

