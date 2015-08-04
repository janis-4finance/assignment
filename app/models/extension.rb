class Extension < Finance::Base
	
	validates :days, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 31 } 
	
	belongs_to :loan
	
	before_create do
		if !loan.blank?
			# set own properties
			self.apr = loan.apr * 1.5
			self.interest = loan.principal * self.apr / 365 / 100 * self.days
			self.total = loan.total + self.interest
		end
  end
	
	after_create do
		# update loan
		loan.maturity_date = loan.maturity_date + self.days.days
		loan.total = self.total
		loan.apr = self.apr
		loan.save
	end
	
end
