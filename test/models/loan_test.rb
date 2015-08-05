require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  test "empty item should not be created" do
		loan = Loan.new
		assert_not loan.save
	end
  test "valid item should be created" do
		loan = Loan.new
		user = User.new( :name => "John", :phone => "12345678", :iban => "LV80BANK0000435195001" )
		user.save
		loan.user = user
		loan.apr = 219.0
		loan.principal = 300.0
		loan.interest = 30.0
		loan.total = loan.principal + loan.interest
		loan.days = 30
		loan.maturity_date = Date.today + 30.days
		loan.user_ip = "127.0.0.1"
		assert loan.save, loan.errors.inspect
	end
end
