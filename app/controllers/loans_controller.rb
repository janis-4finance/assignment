class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :repay, :repay_callback]

  # GET /loans
  # GET /loans.json
  def index
    @user = User.first
    if @user.blank?
      @user = User.new
      @user.save( :validate => false )
    end
    
    @loans = @user.loans
    
    @loan = @user.loans.build
    @loan.principal = 300
    @loan.apr = 219.0
    @loan.days = 30
    @loan.maturity_date = Date.today + 30.days
    @loan.interest = @loan.principal * @loan.apr / 100 / 365 * 30
    @loan.total = @loan.principal + @loan.interest
    
    p '-------'
    p @loan.user_id
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    user = User.first
    if user.blank?
      user = User.new
      user.save( :validate => false )
    end
    @loan = user.loans.build
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    
    user = User.first
    if user.blank?
      user = User.new
      user.save( :validate => false )
    end
    
    @loan = user.loans.build
    
    @loan.assign_attributes( loan_params )
    
    @loan.apr = Loan::APR
    if !@loan.days.blank? && !@loan.principal.blank?
      @loan.maturity_date = Date.today + @loan.days.days
      @loan.interest = @loan.principal * @loan.apr / 365 / 100 * @loan.days
      @loan.total = @loan.principal + @loan.interest
    end
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to root_path, notice: 'Loan was successfully created.' }
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
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:apr, :principal, :days, :interest, :total, :original_apr, :original_interest, :submission_date, :submission_timestamp, :user_attributes => [ :name, :phone, :iban ] )
    end
end
