class User < Finance::Base
  
	validates :name,  presence: true
	validates :phone, presence: true
	validates :iban,  presence: true, uniqueness: true
	
	has_many :loans, lambda{ order( :created_at ) }
	has_one :outstanding_loan, lambda{ where( 'repaid=0' ).where( 'approved=1' ) }, :class_name => 'Loan'
	
	devise :database_authenticatable, :rememberable
	attr_accessor :encrypted_password
	
	def max_amount
		300.0
	end
	
end
