class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans, id: false do |t|
      t.string  :uuid, :primary_key => true, :limit => 36
      t.string  :user_id, limit: 36
      t.decimal :apr,               precision: 8, scale: 4
      t.decimal :principal,         precision: 8, scale: 2
      t.decimal :interest,          precision: 8, scale: 2
      t.decimal :total,             precision: 8, scale: 2
      t.decimal :original_apr,      precision: 8, scale: 4
      t.decimal :original_interest, precision: 8, scale: 2
      t.date    :submission_date
      t.integer :submission_timestamp, limit: 8
      t.boolean :approved,  :default => false
      t.boolean :disbursed, :default => false
      t.boolean :repaid,    :default => false
      t.date    :maturity_date
      t.string  :user_ip
      t.string  :decline_reason
      
      t.timestamps null: false
    end
  end
end
