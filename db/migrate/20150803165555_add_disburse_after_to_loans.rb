class AddDisburseAfterToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :disburse_after, :datetime
  end
end
