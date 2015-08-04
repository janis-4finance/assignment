class ExtensionsController < ApplicationController
	
	def new
		@loan = Loan.find(params[:loan_id])
		@extension = loan.extensions.build
	end
	
	def create
		@loan = Loan.find(params[:loan_id])
		@extension = @loan.extensions.build( extension_params )
		respond_to do |format|
      if @extension.save
        format.html { redirect_to root_path, notice: "Loan extended." }
        format.json { render :show, status: :created, location: @extension }
      else
        format.html { render :new }
        format.json { render json: @extension.errors, status: :unprocessable_entity }
      end
    end
	end
	
	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def extension_params
      params.require(:extension).permit( :days )
    end
	
end
