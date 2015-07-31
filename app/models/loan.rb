class Loan < Finance::Base
	
	self.primary_key = 'uuid'
	
	validates :user_id, :apr, :principal, :interest, :total, :maturity_date, presence: true
	
	belongs_to :user
	
end
