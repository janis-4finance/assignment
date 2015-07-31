require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post :create, loan: { approved: @loan.approved, apr: @loan.apr, decline_reason: @loan.decline_reason, disbursed: @loan.disbursed, interest: @loan.interest, maturity_date: @loan.maturity_date, original_apr: @loan.original_apr, original_interest: @loan.original_interest, principal: @loan.principal, repaid: @loan.repaid, submission_date: @loan.submission_date, submission_timestamp: @loan.submission_timestamp, total: @loan.total, user_id: @loan.user_id, user_ip: @loan.user_ip }
    end

    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should show loan" do
    get :show, id: @loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loan
    assert_response :success
  end

  test "should update loan" do
    patch :update, id: @loan, loan: { approved: @loan.approved, apr: @loan.apr, decline_reason: @loan.decline_reason, disbursed: @loan.disbursed, interest: @loan.interest, maturity_date: @loan.maturity_date, original_apr: @loan.original_apr, original_interest: @loan.original_interest, principal: @loan.principal, repaid: @loan.repaid, submission_date: @loan.submission_date, submission_timestamp: @loan.submission_timestamp, total: @loan.total, user_id: @loan.user_id, user_ip: @loan.user_ip }
    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete :destroy, id: @loan
    end

    assert_redirected_to loans_path
  end
end
