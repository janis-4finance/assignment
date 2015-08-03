module Finance
  class Base < ActiveRecord::Base
    
    self.abstract_class = true
    
    before_create :generate_uuid
    
    def generate_uuid
      self.uuid = UUIDTools::UUID.random_create.to_s if self.uuid.blank?
    end
    
    def self.primary_key
      return "uuid" if connection.column_exists?( table_name, :uuid )
      super
    end
    
  end
end
