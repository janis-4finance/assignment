require 'test_helper'

class HappyPathTest < ActionDispatch::IntegrationTest
	test "Take out a loan" do
		
		get "/"
    assert_response :success
		# user entry must be constructed at this point
		assert @controller.current_user.is_a?( User )
		# new loan form must be present
		assert_select 'form.new_loan_form'
		# no loan history
		assert_select 'table.history.table', 0
		# create a loan
		post_via_redirect "/loans", loan: { principal: 300.0, days: 30, user_attributes: { name: "Jānis Bērziņš", phone: "12345678", iban: "LV80BANK0000435195001" } }
		assert_equal loan_path( assigns(:loan) ), path
		assert assigns(:loan).approved
		assert_not @controller.current_user.outstanding_loan.blank?
		loan = assigns(:loan)
		loan_id = loan.uuid
		
		# let's speed up disbursment
		loan.update_attribute( :disbursed, true )
		
		get "/"
		assert_select 'table.history.table', 1
		assert_select "table.history.table tr[data-id=\"#{loan_id}\"]", 1
		assert_select "table.history.table tr[data-id=\"#{loan_id}\"] .status", "Due in 30 days"
		
		# extend loan
		post_via_redirect "/loans/#{loan_id}/extensions", extension: { days: 7 }
		assert_equal "/", path
		assert_equal "Loan extended.", flash[:notice]
		assert_equal assigns(:extension).loan.total, BigDecimal.new(372.90,8)
		assert_select "table.history.table tr[data-id=\"#{loan_id}\"] .status", "Due in 37 days"
		
		# repay loan
		post_via_redirect "/loans/#{loan_id}/repay"
		assert_select 'form.repay_callback', 1
		post_via_redirect "/loans/#{loan_id}/repay_callback"
		assert_equal "Loan repaid.", flash[:notice]
		assert_select "table.history.table tr[data-id=\"#{loan_id}\"] .status", "Repaid"
		
	end
end
