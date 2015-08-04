class Loan < Finance::Base
	
	APR = 219.0 # annual percentage rate
	
	validates :user_id, :apr, :principal, :interest, :total, :maturity_date, presence: true
	validates :days, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 31 } 
	
	belongs_to :user
	accepts_nested_attributes_for :user, :update_only => true
	
	has_many :extensions
	
	def days_remaining
		return (maturity_date - Date.today).to_i
	end
	
end
