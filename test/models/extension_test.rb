require 'test_helper'

class ExtensionTest < ActiveSupport::TestCase
  test "empty item should not be created" do
		extension = Extension.new
		assert_not extension.save
	end
  test "valid item should be created" do
		loan = loans(:one)
		original_maturity_date = loan.maturity_date
		extension = loan.extensions.build( :days => 7 )
		assert extension.save
		assert_equal (loan.maturity_date - original_maturity_date ).to_i, 7
	end
  
end
