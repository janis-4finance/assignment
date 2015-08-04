class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :repay, :repay_callback]

  # GET /loans
  # GET /loans.json
  def index
    @user = current_user
    
    @loans = @user.loans
    
    @loan = @user.loans.build
    @loan.principal = 300
    @loan.apr = Loan::APR
    @loan.days = 30
    @loan.maturity_date = Date.today + 30.days
    @loan.interest = @loan.principal * @loan.apr / 100 / 365 * 30
    @loan.total = @loan.principal + @loan.interest
    
    if !@user.outstanding_loan.blank?
      @extension = @user.outstanding_loan.extensions.build( :days => 7 )
    end
    
    respond_to do |format|
      format.html
      format.json do
        json = { 'Loan' => @loans }
        render :json => json, :layout => false
      end
    end
    
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    # update disbursed state if the simulated wait period is over
    # this would not be necessary in a production app
    if @loan.approved && @loan.disburse_after <= DateTime.now
      @loan.update_attribute( :disbursed, true )
    end
  end

  # GET /loans/new
  def new
    user = current_user
    @loan = user.loans.build
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    
    user = current_user
    
    @loan = user.loans.build
    
    @loan.assign_attributes( loan_params )
    
    @loan.apr = Loan::APR
    # should consider also request.env["HTTP_X_FORWARDED_FOR"] and request.env['REMOTE_ADDR'] for better protection
    @loan.user_ip = request.remote_ip
    
    if !@loan.days.blank? && !@loan.principal.blank?
      @loan.maturity_date = Date.today + @loan.days.days
      @loan.interest = @loan.principal * @loan.apr / 365 / 100 * @loan.days
      @loan.total = @loan.principal + @loan.interest
    end
    
    # set timestamp to mark as disbursed at - this is a stub and should not exist in an actual app
    @loan.disburse_after = DateTime.now + ( rand(90) + 30 ).seconds # after 30s to 120s
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    #@loan.destroy
    #respond_to do |format|
    #  format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end
  
  # stub to simulate third party payment provider
  def repay
  end
  
  # stub to simulate third party payment provider
  def repay_callback
    respond_to do |format|
      if @loan.update({ repaid: true })
        format.html { redirect_to root_path, notice: 'Loan repaid.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
      if @loan.user_id != current_user.uuid
        render :status => :forbidden, :text => "Forbidden fruit"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit( :principal, :days, :submission_date, :submission_timestamp, :extend_by_days, :user_attributes => [ :name, :phone, :iban ] )
    end
end
