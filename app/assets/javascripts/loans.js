//= require jquery-ui/datepicker

jQuery(function()
{
	var controller = jQuery( '.controller-loans' );
	
	// new loan
	var form = controller.find( '.new_loan_form' );
	if( form.length )
	{
		var principal_input = form.find( 'input[name="loan[principal]"]' );
		var days_input = form.find( 'input[name="loan[days]"]' );
		
		var focus_on_principal_input = false;
		var focus_on_days_input = false;
		
		// create new Loan entry
		var loan = new Finance.Loan();
		
		// validate inputs before assignment - this only has to make sure calculations are possible,
		// server may perform additional validations
		var read_from_inputs = function()
		{
			if( principal_input.val().match( /^\d+$/ ) && Finance.u.cleanup( principal_input.val() ) > 0 )
			{
				loan.set( 'principal', Finance.u.cleanup( principal_input.val() ) );
			}
			if( days_input.val().match( /^\d+$/ ) && Finance.u.cleanup( days_input.val() ) > 0 )
			{
				loan.set( 'days', Finance.u.cleanup( days_input.val() ) );
			}
		}
		
		principal_input.keyup( read_from_inputs );
		days_input.keyup( read_from_inputs );
		
		principal_input.focus(function(){ focus_on_principal_input = true });
		principal_input.blur(function(){ focus_on_principal_input = false });
		
		days_input.focus(function(){ focus_on_days_input = true });
		days_input.blur(function(){ focus_on_days_input = false });
		
		// principal shortcut buttons
		form.find( 'button[name=principal_preset]' ).click(function()
		{
			loan.set( 'principal', jQuery( this ).val() * 1 );
		});
		
		// duration shortcut buttons
		form.find( 'button[name=duration_preset]' ).click(function()
		{
			loan.set( 'days', jQuery( this ).val() * 1 );
		});
		
		var options =
		{
			firstDay:    1, // start week with monday
			minDate:     1,  // no dates in past
			maxDate:     30,  // up to 30 days
			defaultDate: 30
		};
		var datepicker = form.find( '.calendar' ).datepicker( options );
		
		datepicker.datepicker( 'option', 'onSelect', function( date_string )
		{
			var date = jQuery.datepicker.parseDate( 'mm/dd/yy', date_string );
			var no_of_days = Math.ceil( ( date.getTime() - ( new Date() ).getTime() ) / ( 24 * 60 * 60 * 1000 ) );
			loan.set( 'days', no_of_days );
		});
		
		datepicker.datepicker( 'option', 'gotoCurrent', true );
		
		// reflect mutations in dom
		loan.on( 'mutate', function()
		{
			var self = this;
			var changes = self.changes();
			
			console.log( 'Loan mutated, changes:', changes );
			
			if( changes.principal && !focus_on_principal_input )
			{
				principal_input.val( self.principal );
			}
			
			if( changes.days )
			{
				// update days input
				if( !focus_on_days_input )
				{
					days_input.val( self.days );
				}
				datepicker.datepicker( 'setDate', self.days );
				var maturity_date = new Date( (new Date()).getTime() + self.days * 24 * 60 * 60 * 1000 );
				form.find( '.maturity_date' ).html( Finance.u.date( 'd.m.Y', maturity_date ) );
			}
			
			// update totals
			if( changes.principal || changes.days )
			{
				form.find( '.principal' ).html( loan.principal.toFixed(2) );
				form.find( '.interest' ).html( loan.get_interest().toFixed(2) );
				form.find( '.total .value' ).html( loan.get_total().toFixed(2) );
				form.find( '.summary .line[data-no_of_days]' ).each(function( item )
				{
					var node = jQuery( this );
					node.find( '.value' ).html( loan.get_extension_cost( node.attr( 'data-no_of_days' ) * 1 ).toFixed(2) );
				});
			}
			
		});
		
		read_from_inputs(); // set initial values
	}
	
	
	
});

