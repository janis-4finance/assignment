require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  test "empty item should not be created" do
		loan = Loan.new
		assert_not loan.save
	end
  test "valid item should be created" do
		loan = Loan.new
		user = User.new
		user.save( :validate => false )
		loan.user = user
		loan.apr = 219.0
		loan.principal = 300.0
		loan.interest = 30.0
		loan.total = loan.principal + loan.interest
		loan.original_apr = loan.apr
		loan.original_interest = loan.interest
		loan.submission_date = Date.today
		loan.submission_timestamp = DateTime.now.to_i
		loan.maturity_date = loan.submission_date + 30.days
		loan.user_ip = "127.0.0.1"
		assert loan.save
	end
end
