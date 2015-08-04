//= require jquery-ui/datepicker

jQuery(function()
{
	// new loan
	var form = jQuery( 'form.new_extension' );
	if( form.length )
	{
		var days_input = form.find( 'input[name="extension[days]"]' );
		
		var focus_on_days_input = false;
		
		// create models
		var loan = Finance.Loan.create_or_update( form.attr( 'data-loan_id' ) );
		var extension = new Finance.Extension({ loan_id: loan.uuid });
		
		// validate inputs before assignment - this only has to make sure calculations are possible,
		// server may perform additional validations
		var read_from_inputs = function()
		{
			if( days_input.val().match( /^\d+$/ ) && Finance.u.cleanup( days_input.val() ) > 0 )
			{
				extension.set( 'days', Finance.u.cleanup( days_input.val() ) );
			}
		}
		
		days_input.keyup( read_from_inputs );
		
		days_input.focus(function(){ focus_on_days_input = true });
		days_input.blur(function(){ focus_on_days_input = false });
		
		// duration shortcut buttons
		form.find( 'button[name=duration_preset]' ).click(function()
		{
			extension.set( 'days', jQuery( this ).val() * 1 );
		});
		
		var options =
		{
			firstDay:    1,   // start week with monday
			minDate:     1,   // no dates in past
			maxDate:     30,  // up to 30 days
			defaultDate: 7
		};
		var datepicker = form.find( '.calendar' ).datepicker( options );
		
		datepicker.datepicker( 'option', 'onSelect', function( date_string )
		{
			var date = jQuery.datepicker.parseDate( 'mm/dd/yy', date_string );
			var no_of_days = Math.ceil( ( date.getTime() - ( new Date() ).getTime() ) / ( 24 * 60 * 60 * 1000 ) );
			extension.set( 'days', no_of_days );
		});
		
		datepicker.datepicker( 'option', 'gotoCurrent', true );
		
		// reflect mutations in dom
		extension.on( 'mutate', function()
		{
			var self = this;
			var changes = self.changes();
			
			console.log( 'Extension mutated, changes:', changes );
			
			if( changes.principal && !focus_on_principal_input )
			{
				principal_input.val( self.principal );
			}
			
			if( changes.days || Finance.u.to_array( changes ).length == 0 )
			{
				// update days input
				if( !focus_on_days_input )
				{
					days_input.val( self.days );
				}
				datepicker.datepicker( 'setDate', self.days );
				
				var loan = self.loan();
				
				if( loan.principal ) // loan might not have loaded yet
				{
					var maturity_date = new Date( (new Date()).getTime() + self.days * 24 * 60 * 60 * 1000 );
					form.find( '.maturity_date' ).html( Finance.u.date( 'd.m.Y', maturity_date ) );
					
					form.find( '.principal' ).html( loan.principal.toFixed(2) );
					form.find( '.interest' ).html( loan.get_interest().toFixed(2) );
					form.find( '.extension_cost' ).html( loan.get_extension_cost( extension.days ).toFixed(2) );
					form.find( '.new_total' ).html( extension.get_total().toFixed(2) );
				}
			}
		});
		
		loan.on( 'mutate', function(){ extension.trigger( 'mutate' ) });
		
		read_from_inputs(); // set initial values
	}
});
