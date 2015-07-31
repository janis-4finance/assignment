class User < Finance::Base
	
	self.primary_key = 'uuid'
	
	validates :name,  presence: true
	validates :phone, presence: true
	validates :iban,  presence: true, uniqueness: true
	
	has_many :loans
	
end
