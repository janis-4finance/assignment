class AddDaysToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :days, :integer, :after => :repaid
  end
end
