module Finance
  class Base < ActiveRecord::Base
    
    self.abstract_class = true
    
    self.primary_key = 'uuid'
    
    before_create :generate_uuid
    
    def generate_uuid
      self.uuid = UUIDTools::UUID.random_create.to_s if self.uuid.blank?
    end
    
  end
end
