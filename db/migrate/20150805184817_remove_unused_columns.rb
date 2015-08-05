class RemoveUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :loans, :original_apr
    remove_column :loans, :original_interest
    remove_column :loans, :submission_date
    remove_column :loans, :submission_timestamp
  end
end
