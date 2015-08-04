Finance.utils =
{
	/**
	 * numbers
	 */
	thousands: function( number, separator )
	{
		var expression = new RegExp('(-?[0-9]+)([0-9]{3})');
		var separated = Finance.utils.cleanup( number ) + '';
		
		if( separator === undefined )
		{
			separator = ' ';
		}
		while( expression.test( separated ) )
		{
			separated = separated.replace( expression, '$1' + separator + '$2' );
		}
		return separated;
	},
	cleanup: function( number )
	{
		if( number === null )
		{
			return 0;
		}
		number += '';
		number = number.replace( / /gi, '' );
		number = number.replace( /,/i, '.' );
		if( isNaN( number ) )
		{
			return 0;
		}
		return number * 1;
	},
	format: function( number, precision, separator )
	{
		number = Finance.utils.cleanup( number );
		if( precision === undefined )
		{
			precision = 2;
		}
		if( precision === false )
		{
			return Finance.utils.thousands( number, separator );
		}
		else
		{
			return Finance.utils.thousands( number.toFixed( precision ), separator );
		}
	},
	to_array: function( object )
	{
		if( object instanceof Array )
		{
			return object;
		}
		var array = [];
		for( var i in object )
		{
			array.push( object[i] );
		}
		return array;
	},
	/**
	 * return formatted date
	 *
	 * supported placeholders: 'Y', 'm', 'd', 'H', 'i', 's' 
	 */
	date: function( format, date )
	{
		format = format || 'Y-m-d H:i:s';
		
		var is_numeric = function (obj)
		{
			return !isNaN(parseFloat(obj)) && isFinite(obj);
		}
		
		if( is_numeric( date ) )
		{
			date = new Date( date );
		}
		if( date instanceof Date == false )
		{
			date = new Date();
		}
        
		var replacements =
		{
			Y: date.getFullYear(),
			m: date.getMonth() + 1,
			d: date.getDate(),
			H: date.getHours(),
			i: date.getMinutes(),
			s: date.getSeconds()
		};
		
		for( var i in replacements )
		{
			// pad with zeros
			replacements[i] += '';
			if( replacements[i].length == 1 )
			{
				replacements[i] = '0' + replacements[i];
			}
			// replace
			format = format.replace( new RegExp( i ), replacements[i] );
		}
		return format;
	},
	ordinalize: function( n )
	{
		var s = ["th","st","nd","rd"];
		return n + ( s[(n%100-20)%10] || s[n%100] || s[0] );
	}
}

Finance.u = Finance.utils;
Finance.u.toArray = Finance.u.to_array;
