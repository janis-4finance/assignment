class User < Finance::Base
	
	validates :name, presence: true
	validates :phone, presence: true
	validates :iban, presence: true, uniqueness: true
	
end
